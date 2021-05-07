//
//  ContentView.swift
//  BeerApp
//
//  Created by Andrea Stevanato on 29/03/21.
//

import CoreData
import SwiftUI

struct BeerListView: View {

    @StateObject private var viewModel = BeerListViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.beers, id: \.id) { beer in
                    Text("\(beer.id) \(beer.name) - \(beer.tagline)")
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle(viewModel.title)
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    EditButton()
                    Spacer()
                    Button("Refresh", action: viewModel.getBeers)
                    Spacer()
                    Button(action: deleteAllBeer) {
                        Label("Delete All", systemImage: "trash")
                    }
                }
            }
            .onAppear(perform: {
                viewModel.getBeers()
            })
        }
    }

    private func deleteAllBeer() {
        withAnimation {
            viewModel.deleteAll()
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { viewModel.deleteBeer(index: $0) }
        }
    }
}
