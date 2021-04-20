//
//  BeerRepository.swift
//  BeerApp
//
//  Created by Andrea Stevanato on 14/04/21.
//

import CoreData
import Foundation

protocol BeerRepositoryType: RepositoryType {
    func get(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> Result<[Beer], Error>
    func create(beer: Beer) -> Result<Bool, Error>
    func delete(id: Int) -> Result<Bool, Error>
    func deleteAll() -> Result<Bool, Error>
}

class BeerRepository: BeerRepositoryType {

    private let repository: CoreDataRepository<BeerMO>

    required init(context: NSManagedObjectContext) {
        self.repository = CoreDataRepository<BeerMO>(managedObjectContext: context)
    }

    @discardableResult
    func get(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> Result<[Beer], Error> {
        let result = repository.get(predicate: predicate, sortDescriptors: sortDescriptors)
        switch result {
        case .success(let beersMO):
            let beers = beersMO.map { beerMO -> Beer in
                beerMO.toDomainModel()
            }
            return .success(beers)
        case .failure(let error):
            return .failure(error)
        }
    }

    @discardableResult
    func create(beer: Beer) -> Result<Bool, Error> {
        let result = repository.create()
        switch result {
        case .success(let beerMO):
            // TODO: Complete with remaining properties
            beerMO.id = Int32(beer.id)
            beerMO.name = beer.name
            beerMO.tagline = beer.tagline
            beerMO.desc = beer.description
            return .success(true)

        case .failure(let error):
            return .failure(error)
        }
    }

    @discardableResult
    func delete(id: Int) -> Result<Bool, Error> {
        let result = repository.get(predicate: NSPredicate(format: "id == %@", String(id)), sortDescriptors: nil)
        switch result {
        case .success(let beers):
            beers.forEach { repository.delete(entity: $0) }
            return .success(true)
        case .failure(let error):
            return .failure(error)
        }
    }

    @discardableResult
    func deleteAll() -> Result<Bool, Error> {
        repository.deleteAll()
    }
}
