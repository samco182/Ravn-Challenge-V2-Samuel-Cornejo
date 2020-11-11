//
//  Person+Extensions.swift
//  RavnChallenge
//
//  Created by Samuel Cornejo on 11/10/20.
//

import Foundation

extension Person {
    /// Short description of this person species and homeworld
    var shortDescription: String {
        guard let home = homeworld?.name else { return "" }

        if let species = species?.name {
            return "\(species) from \(home)"
        } else {
            return "Human from \(home)"
        }
    }


    /// A list of the available vehicles for this person
    var vehicles: [Vehicle] {
        vehicleConnection?.vehicles?.compactMap { $0 } ?? []
    }
}

extension Person: Identifiable, Equatable {
    public static func == (lhs: StarWarsPeopleQuery.Data.AllPerson.Person,
                           rhs: StarWarsPeopleQuery.Data.AllPerson.Person) -> Bool {
        lhs.id == rhs.id
    }
}
