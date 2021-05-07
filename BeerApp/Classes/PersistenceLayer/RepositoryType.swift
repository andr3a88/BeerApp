//
//  RepositoryType.swift
//  BeerApp
//
//  Created by Davide Sibilio on 14/04/21.
//

import CoreData
import Foundation

protocol RepositoryType {

    associatedtype ManagedModel

    init(context: NSManagedObjectContext)

    func get(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> Result<[ManagedModel], Error>
    func create(beer: ManagedModel) -> Result<Bool, Error>
    func delete(id: Int) -> Result<Bool, Error>
    func deleteAll() -> Result<Bool, Error>
}

extension RepositoryType {
    static func getUnitOfWork(for context: NSManagedObjectContext) -> UnitOfWork<ManagedModel> {
        UnitOfWork(context: context, repositoryType: Self.self)
    }
}
