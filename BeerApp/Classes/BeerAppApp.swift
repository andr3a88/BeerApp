//
//  BeerAppApp.swift
//  BeerApp
//
//  Created by Andrea Stevanato on 29/03/21.
//

import SwiftUI

@main
struct BeerApp: App {

    @UIApplicationDelegateAdaptor(BeerAppDelegate.self) var appDelegate

    let coreDataContextProvider = CoreDataContextProvider.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, coreDataContextProvider.viewContext)
        }
    }
}
