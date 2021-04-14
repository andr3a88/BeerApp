//
//  AnyRepositoryType.swift
//  BeerApp
//
//  Created by Davide Sibilio on 14/04/21.
//

import CoreData

class AnyRepositoryType<AnyManagedModel>: RepositoryType {

    typealias ManagedModel = AnyManagedModel

    private let _get: (NSPredicate?) -> Result<[ManagedModel], Error>
    private let _create: (ManagedModel) -> Result<Bool, Error>

    init<T: RepositoryType>(_ repository: T) where T.ManagedModel == AnyManagedModel {
        self._get = repository.get
        self._create = repository.create
    }

    required init(context: NSManagedObjectContext) {
        fatalError("this is an erasure type class, could be not instantiated")
    }

    @discardableResult
    func get(predicate: NSPredicate?) -> Result<[AnyManagedModel], Error> {
        _get(predicate)
    }

    @discardableResult
    func create(beer: AnyManagedModel) -> Result<Bool, Error> {
        _create(beer)
    }
}
