//
//  UnitOfWork.swift
//  BeerApp
//
//  Created by Andrea Stevanato on 14/04/21.
//

import CoreData
import Foundation

/// https://www.c-sharpcorner.com/UploadFile/b1df45/unit-of-work-in-repository-pattern/
final class UnitOfWork {

    private let context: NSManagedObjectContext
    
    let beerRepository: BeerRepository

    /// Init a unit of work
    /// - Parameter context: The NSManagedObjectContext instance
    init(context: NSManagedObjectContext) {
        self.context = context
        self.beerRepository = BeerRepository(context: context)
    }

    /// Save the NSManagedObjectContext.
    @discardableResult func saveChanges() -> Result<Bool, Error> {
        do {
            try context.save()
            return .success(true)
        } catch {
            context.rollback()
            return .failure(error)
        }
    }
}
