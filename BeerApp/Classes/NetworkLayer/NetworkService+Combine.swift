//
//  NetworkService+Combine.swift
//  BeerApp
//
//  Created by Davide Sibilio on 02/04/21.
//

import Combine
import Foundation

public extension NetworkService {
    func getDeferred(taskQueue: DispatchQueue = .global(qos: .utility)) -> AnyPublisher<NetworkResponse<Self.ResponseModel>, Error> {
        Deferred {
            getFuture(taskQueue: taskQueue)
        }.eraseToAnyPublisher()
    }

    func getFuture(taskQueue: DispatchQueue = .global(qos: .utility)) -> Future<NetworkResponse<Self.ResponseModel>, Error> {
        Future { promise in
            self.perform(queue: taskQueue) { result in
                promise(result)
            }
        }
    }
}
