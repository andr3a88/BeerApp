//
//  Ingredients.swift
//  BeerApp
//
//  Created by Davide Sibilio on 02/04/21.
//

import Foundation

struct Ingredients: Codable {
    let malt: [Malt]
    let hops: [Hop]
    let yeast: String
}
