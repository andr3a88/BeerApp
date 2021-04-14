//
//  RemoteBeer.swift
//  BeerApp
//
//  Created by Davide Sibilio on 02/04/21.
//

import Foundation

struct Beer: Codable {
    let id: Int
    let name, tagline, firstBrewed, description: String
    let imageURL: String
    let abv: Double
    let ibu: Double?
    let targetFg: Int
    let targetOg: Double
    let ebc: Int?
    let srm: Double?
    let attenuationLevel: Double
    let volume, boilVolume: BoilVolume
    let ingredients: Ingredients
    let foodPairing: [String]
    let brewersTips: String
    let contributedBy: String

    enum CodingKeys: String, CodingKey {
        case id, name, tagline
        case firstBrewed = "first_brewed"
        case description
        case imageURL = "image_url"
        case abv, ibu
        case targetFg = "target_fg"
        case targetOg = "target_og"
        case ebc, srm
        case attenuationLevel = "attenuation_level"
        case volume
        case boilVolume = "boil_volume"
        case ingredients
        case foodPairing = "food_pairing"
        case brewersTips = "brewers_tips"
        case contributedBy = "contributed_by"
    }

    internal init(id: Int, name: String, tagline: String, firstBrewed: String, description: String, imageURL: String, abv: Double,
                  ibu: Double?, targetFg: Int, targetOg: Double, ebc: Int?, srm: Double?, attenuationLevel: Double,
                  volume: BoilVolume, boilVolume: BoilVolume, ingredients: Ingredients, foodPairing: [String], brewersTips: String, contributedBy: String) {
        self.id = id
        self.name = name
        self.tagline = tagline
        self.firstBrewed = firstBrewed
        self.description = description
        self.imageURL = imageURL
        self.abv = abv
        self.ibu = ibu
        self.targetFg = targetFg
        self.targetOg = targetOg
        self.ebc = ebc
        self.srm = srm
        self.attenuationLevel = attenuationLevel
        self.volume = volume
        self.boilVolume = boilVolume
        self.ingredients = ingredients
        self.foodPairing = foodPairing
        self.brewersTips = brewersTips
        self.contributedBy = contributedBy
    }

    static func getStub(name: String = "Beer") -> Beer {
        Beer(id: 0, name: name, tagline: "", firstBrewed: "", description: "",
             imageURL: "", abv: 0, ibu: 0, targetFg: 0, targetOg: 0,
             ebc: 0, srm: 0, attenuationLevel: 0, volume: BoilVolume(value: 0, unit: .kilograms),
             boilVolume: BoilVolume(value: 0, unit: .kilograms), ingredients: Ingredients(malt: [], hops: [], yeast: ""),
             foodPairing: [], brewersTips: "",
             contributedBy: "")
    }
}
