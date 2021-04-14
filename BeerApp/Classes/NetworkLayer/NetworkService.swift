//
//  NetworkService.swift
//  BeerApp
//
//  Created by Davide Sibilio on 02/04/21.
//

import Foundation

public typealias CachePolicy = URLRequest.CachePolicy
public typealias DateDecodingStrategy = JSONDecoder.DateDecodingStrategy

public protocol NetworkService {

    associatedtype ResponseModel: Decodable

    typealias ResultType = Result<NetworkResponse<ResponseModel>, Error>

    var acceptedStatusCodes: Set<Int> { get }

    var cachePolicy: CachePolicy { get }

    var dateDecodingStrategy: DateDecodingStrategy { get }
    
    var rootEndpoint: String { get }

    var endpoint: String { get }

    var method: HTTPMethod { get }

    var queryRequest: NetworkRequest? { get }

    var request: NetworkRequest? { get }

    var headers: [String: String] { get }

    var shouldReturnCachedResponseOnError: Bool { get }

    var timeoutInterval: TimeInterval { get }

    func getCachedResponse() -> NetworkResponse<ResponseModel>?
    func perform(queue: DispatchQueue, completion: (((ResultType)) -> Void)?)
}

public extension NetworkService {

    var acceptedStatusCodes: Set<Int> {
        .init(200..<300)
    }

    var cachePolicy: CachePolicy {
        .useProtocolCachePolicy
    }

    var dateDecodingStrategy: DateDecodingStrategy {
        .deferredToDate
    }

    var headers: [String: String] {
        [:]
    }

    var method: HTTPMethod {
        .get
    }

    var queryRequest: NetworkRequest? {
        nil
    }

    var request: NetworkRequest? {
        nil
    }

    var shouldReturnCachedResponseOnError: Bool {
        false
    }

    var timeoutInterval: TimeInterval {
        #if DEBUG
        return 60
        #else
        return 10
        #endif
    }

    private var url: URL? {
        let path = rootEndpoint + endpoint
        if let queryRequest = queryRequest {
            var components = URLComponents(string: path)
            components?.queryItems = queryRequest.asQueryItems
            return components?.url
        } else {
            return URL(string: path)
        }
    }

    private func asURLRequest() throws -> URLRequest {
        guard let url = url else {
            throw NSError(domain: "URL not valid: \(rootEndpoint + endpoint)", code: 404, userInfo: [:])
        }
        var urlRequest = URLRequest(url: url)
        if let request = request {
            urlRequest.httpBody = request.asData
            urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
        }
        for header in headers {
            urlRequest.setValue(header.value, forHTTPHeaderField: header.key)
        }
        urlRequest.cachePolicy = cachePolicy
        urlRequest.timeoutInterval = timeoutInterval
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }

    private func catchError(_ error: Error, urlRequest: URLRequest, response: HTTPURLResponse?) -> ResultType {
        if
          shouldReturnCachedResponseOnError,
          let cachedData = URLCache.shared.cachedResponse(for: urlRequest)?.data {
            return decodeData(cachedData, response: response, wasCached: true)
        } else {
            return .failure(error)
        }
    }

    private func decodeData(_ data: Data, response: HTTPURLResponse?, wasCached: Bool) -> ResultType {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = dateDecodingStrategy
            let responseModel = try decoder.decode(ResponseModel.self, from: data)
            let wrapper = NetworkResponse(headers: response?.allHeaderFields ?? [:], model: responseModel, wasCached: wasCached)
            return .success(wrapper)
        } catch let error {
            return .failure(error)
        }
    }

    internal func performDataTask(completion: @escaping (ResultType) -> Void) {
        do {
            let urlRequest = try asURLRequest()
            let oldData = URLCache.shared.cachedResponse(for: urlRequest)?.data
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                let urlResponse = response as? HTTPURLResponse
                if let error = error {
                    completion(self.catchError(error, urlRequest: urlRequest, response: urlResponse))
                    return
                }
                guard
                  let statusCode = urlResponse?.statusCode,
                  self.acceptedStatusCodes.contains(statusCode),
                  let data = data else {
                    let error = NSError(domain: "No Data", code: 0, userInfo: [:])
                    completion(self.catchError(error, urlRequest: urlRequest, response: urlResponse))
                    return
                }
                completion(self.decodeData(data, response: urlResponse, wasCached: oldData == data))
            }
            dataTask.resume()
        } catch let error {
            completion(.failure(error))
        }
    }

    func getCachedResponse() -> NetworkResponse<ResponseModel>? {
        do {
            if let cachedData = URLCache.shared.cachedResponse(for: try self.asURLRequest())?.data {
                return try decodeData(cachedData, response: nil, wasCached: true).get()
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }

    func perform(queue: DispatchQueue = .main, completion: ((ResultType) -> Void)? = nil) {
        performDataTask { result in
            queue.async {
                completion?(result)
            }
        }
    }
}
