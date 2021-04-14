//
//  BeerAppDelegate.swift
//  BeerApp
//
//  Created by Davide Sibilio on 02/04/21.
//

import Combine
import UIKit

class BeerAppDelegate: NSObject, UIApplicationDelegate {
    
    private var disposeBag = Set<AnyCancellable>()
    private let coreDataContextProvider = CoreDataContextProvider.shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        let service = GetBeersService()
        let unitOfWork = BeerRepository.getUnitOfWork(for: self.coreDataContextProvider.newBackgroundContext())
        service.getDeferred()
            .sink { completion in
                print("Completion: \(completion)")
            } receiveValue: { value in
                value.model.forEach {
                    unitOfWork.repository.create(beer: $0)
                }
                unitOfWork.saveChanges()
            }
            .store(in: &disposeBag)

        return true
    }
}
