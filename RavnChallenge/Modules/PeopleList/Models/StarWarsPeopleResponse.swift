//
//  StarWarsPeopleResponse.swift
//  RavnChallenge
//
//  Created by Samuel Cornejo on 11/10/20.
//

import Foundation

typealias StarWarsPeople = StarWarsPeopleQuery.Data.AllPerson.Person
typealias StarWarsPage = StarWarsPeopleQuery.Data.AllPerson.PageInfo

struct StarWarsPeopleResponse {
    // MARK: Variables Declaration
    let people: [StarWarsPeople]
    let page: StarWarsPage

    // MARK: Initializer
    init(data: StarWarsPeopleQuery.Data) {
        self.people = data.allPeople?.people?.compactMap { $0 } ?? []
        self.page = data.allPeople?.pageInfo ?? StarWarsPage(hasNextPage: false)
    }
}
