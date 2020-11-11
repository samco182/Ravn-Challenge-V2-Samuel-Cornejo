//
//  Person+Extensions.swift
//  RavnChallenge
//
//  Created by Samuel Cornejo on 11/10/20.
//

import Foundation

typealias Person = StarWarsPeopleQuery.Data.AllPerson.Person
typealias Vehicle = StarWarsPeopleQuery.Data.AllPerson.Person.VehicleConnection.Vehicle
typealias PageInformation = StarWarsPeopleQuery.Data.AllPerson.PageInfo

extension Person {
    var shortDescription: String {
        guard let home = homeworld?.name else { return "" }

        if let species = species?.name {
            return "\(species) from \(home)"
        } else {
            return "Human from \(home)"
        }
    }

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
