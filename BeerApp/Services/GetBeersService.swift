//
//  GetBeersService.swift
//  BeerApp
//
//  Created by Davide Sibilio on 02/04/21.
//

import Foundation

struct GetBeersService: BeerNetworkService {
    typealias ResponseModel = [Beer]
    
    let endpoint: String = "beers"
}
