//
//  BeerRepository.swift
//  BeerApp
//
//  Created by Andrea Stevanato on 14/04/21.
//

import CoreData
import Foundation

protocol BeerRepositoryType {
    func getBeers(predicate: NSPredicate?) -> Result<[Beer], Error>
    func create(beer: Beer) -> Result<Bool, Error>
}

class BeerRepository: BeerRepositoryType {

    private let repository: CoreDataRepository<BeerMO>

    init(context: NSManagedObjectContext) {
        self.repository = CoreDataRepository<BeerMO>(managedObjectContext: context)
    }

    @discardableResult
    func getBeers(predicate: NSPredicate?) -> Result<[Beer], Error> {
        let result = repository.get(predicate: predicate, sortDescriptors: nil)
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
            beerMO.id = Int32(beer.id)
            beerMO.name = beer.name
            // TODO: Complete with remaining properties
            return .success(true)

        case .failure(let error):
            return .failure(error)
        }
    }
}
