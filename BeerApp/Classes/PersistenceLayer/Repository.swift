//
//  Repository.swift
//  BeerApp
//
//  Created by Andrea Stevanato on 13/04/21.
//

import Foundation

protocol Repository {

    associatedtype Entity

    func get(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> Result<[Entity], Error>

    func create() -> Result<Entity, Error>
    func delete(entity: Entity) -> Result<Bool, Error>
}
