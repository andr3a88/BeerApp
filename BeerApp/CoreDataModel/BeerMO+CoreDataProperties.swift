//
//  BeerMO+CoreDataProperties.swift
//  BeerApp
//
//  Created by Andrea Stevanato on 14/04/21.
//
//

import CoreData
import Foundation

extension BeerMO {

    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<BeerMO> {
        NSFetchRequest<BeerMO>(entityName: "BeerMO")
    }

    @NSManaged public var desc: String
    @NSManaged public var id: Int32
    @NSManaged public var name: String
    @NSManaged public var tagline: String
}

extension BeerMO: Identifiable {}

extension BeerMO: DomainModel {
    func toDomainModel() -> Beer {
        Beer.getStub(id: id, name: name, tagline: tagline, description: desc)
    }
}
