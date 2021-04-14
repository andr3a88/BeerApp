//
//  UnitOfWork.swift
//  BeerApp
//
//  Created by Andrea Stevanato on 14/04/21.
//

import CoreData
import Foundation

/// https://www.c-sharpcorner.com/UploadFile/b1df45/unit-of-work-in-repository-pattern/
final class UnitOfWork<T> {

    private let context: NSManagedObjectContext

    let repository: AnyRepositoryType<T>

    /// Init a unit of work
    /// - Parameter context: The NSManagedObjectContext instance
    init<Repo: RepositoryType>(context: NSManagedObjectContext, repositoryType: Repo.Type) where T == Repo.ManagedModel {
        self.context = context
        let repo = repositoryType.init(context: context)
        self.repository = AnyRepositoryType(repo)
    }

    /// Save the NSManagedObjectContext.
    @discardableResult
    func saveChanges() -> Result<Bool, Error> {
        do {
            try context.save()
            return .success(true)
        } catch let error {
            context.rollback()
            return .failure(error)
        }
    }
}
