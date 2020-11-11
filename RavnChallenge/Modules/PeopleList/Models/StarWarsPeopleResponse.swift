//
//  StarWarsPeopleResponse.swift
//  RavnChallenge
//
//  Created by Samuel Cornejo on 11/10/20.
//

import Foundation

typealias Person = StarWarsPeopleQuery.Data.AllPerson.Person
typealias Vehicle = StarWarsPeopleQuery.Data.AllPerson.Person.VehicleConnection.Vehicle
typealias PageInformation = StarWarsPeopleQuery.Data.AllPerson.PageInfo

struct StarWarsPeopleResponse {
    // MARK: Variables Declaration
    let people: [Person]
    let page: PageInformation

    // MARK: Initializer
    init(data: StarWarsPeopleQuery.Data) {
        self.people = data.allPeople?.people?.compactMap { $0 } ?? []
        self.page = data.allPeople?.pageInfo ?? PageInformation(hasNextPage: false)
    }
}
