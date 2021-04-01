//
//  BeerService.swift
//  BeerApp
//
//  Created by Davide Sibilio on 02/04/21.
//

import Foundation

protocol BeerNetworkService: NetworkService {}

extension BeerNetworkService {
    var rootEndpoint: String { "https://api.punkapi.com/v2/" }
}
