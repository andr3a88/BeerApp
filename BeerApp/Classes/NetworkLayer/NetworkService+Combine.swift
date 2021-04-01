//
//  NetworkService+Combine.swift
//  BeerApp
//
//  Created by Davide Sibilio on 02/04/21.
//

import Combine
import Foundation

extension NetworkService {
    public func getDeferred(taskQueue: DispatchQueue = .global(qos: .utility)) -> AnyPublisher<NetworkResponse<Self.ResponseModel>, Error> {
        Deferred {
            Future() { promise in
                self.perform(queue: taskQueue) { result in
                    promise(result)
                }
            }
        }.eraseToAnyPublisher()
    }
}
