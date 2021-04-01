//
//  NetworkResponse.swift
//  BeerApp
//
//  Created by Davide Sibilio on 02/04/21.
//

import Foundation

public struct NetworkResponse<T> {
    public let headers: [AnyHashable: Any]
    public let model: T
    public let wasCached: Bool
    
    public init(model: T) {
        self.model = model
        self.headers = [:]
        self.wasCached = false
    }
    
    init(headers: [AnyHashable: Any], model: T, wasCached: Bool) {
        self.headers = headers
        self.model = model
        self.wasCached = wasCached
    }

    public func changeModel(_ model: T) -> Self {
        NetworkResponse<T>(headers: headers, model: model, wasCached: wasCached)
    }
}
