//
//  BeerListViewModel.swift
//  BeerApp
//
//  Created by Andrea Stevanato on 20/04/21.
//

import Foundation

class BeerListViewModel: ObservableObject {
    
    private let beerRepository = BeerRepository(context: CoreDataContextProvider.shared.newBackgroundContext())

    var title: String = "Beer List"
    @Published var beers: [BeerViewModel] = []

    func getBeers() {
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        switch beerRepository.get(predicate: nil, sortDescriptors: [sortDescriptor]) {
        case .success(let fetchedBeers):
            beers = fetchedBeers.map { BeerViewModel(beer: $0) }
        case .failure:
            beers = []
        }
    }

    func deleteBeer(index: Int) {
        switch beerRepository.delete(id: beers[index].id) {
        case .success:
            getBeers()
        case .failure:
            break
        }
    }

    func deleteAll() {
        beerRepository.deleteAll()
        getBeers()
    }

    func fetchFromService() {
        // TODO
    }
}

struct BeerViewModel {

    let beer: Beer

    var id: Int { beer.id }
    var name: String { beer.name }
    var tagline: String { beer.tagline }
}
