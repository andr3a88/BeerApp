//
//  DomainModel.swift
//  BeerApp
//
//  Created by Andrea Stevanato on 14/04/21.
//

import Foundation

protocol DomainModel {
    associatedtype DomainModelType

    func toDomainModel() -> DomainModelType
}
