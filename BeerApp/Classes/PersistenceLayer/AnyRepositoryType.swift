//
//  AnyRepositoryType.swift
//  BeerApp
//
//  Created by Davide Sibilio on 14/04/21.
//

import CoreData

class AnyRepositoryType<AnyManagedModel>: RepositoryType {

    typealias ManagedModel = AnyManagedModel

    private let _get: (NSPredicate?, [NSSortDescriptor]?) -> Result<[ManagedModel], Error>
    private let _create: (ManagedModel) -> Result<Bool, Error>
    private let _delete: (Int) -> Result<Bool, Error>
    private let _deleteAll: () -> Result<Bool, Error>

    init<T: RepositoryType>(_ repository: T) where T.ManagedModel == AnyManagedModel {
        self._get = repository.get
        self._create = repository.create
        self._delete = repository.delete
        self._deleteAll = repository.deleteAll
    }

    required init(context: NSManagedObjectContext) {
        fatalError("this is an erasure type class, could be not instantiated")
    }

    @discardableResult
    func get(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> Result<[AnyManagedModel], Error> {
        _get(predicate, sortDescriptors)
    }

    @discardableResult
    func create(beer: AnyManagedModel) -> Result<Bool, Error> {
        _create(beer)
    }

    @discardableResult
    func delete(id: Int) -> Result<Bool, Error> {
        _delete(id)
    }

    @discardableResult
    func deleteAll() -> Result<Bool, Error> {
        _deleteAll()
    }
}
