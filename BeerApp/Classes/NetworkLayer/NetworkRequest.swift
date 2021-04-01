//
//  NetworkRequest.swift
//  BeerApp
//
//  Created by Davide Sibilio on 02/04/21.
//

import Foundation

public protocol NetworkRequest: Encodable {}

public extension NetworkRequest {

    var asData: Data {
        do {
            return try JSONEncoder().encode(self)
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }

    var asDictionary: [String: Any] {
        guard
            let data = try? JSONEncoder().encode(self),
            let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
            else {
                return [:]
        }
        return dictionary
    }

    var asQueryItems: [URLQueryItem] {
        asDictionary.map { element in URLQueryItem(name: element.key, value: "\(element.value)") }
    }
}
