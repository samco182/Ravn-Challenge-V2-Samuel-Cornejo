//
//  Vehicle+Extensions.swift
//  RavnChallenge
//
//  Created by Samuel Cornejo on 11/11/20.
//

import Foundation

extension Vehicle: Identifiable, Equatable {
    public static func == (lhs: StarWarsPeopleQuery.Data.AllPerson.Person.VehicleConnection.Vehicle,
                           rhs: StarWarsPeopleQuery.Data.AllPerson.Person.VehicleConnection.Vehicle) -> Bool {
        lhs.id == rhs.id
    }
}
