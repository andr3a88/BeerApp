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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        let service = GetBeersService()
        service.getDeferred()
            .sink { completion in
                print("Completion: \(completion)")
            } receiveValue: { value in
                print("Value: \(value)")
            }
            .store(in: &disposeBag)
        
        return true
    }
}
