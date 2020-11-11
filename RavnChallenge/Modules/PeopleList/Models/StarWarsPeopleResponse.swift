//
//  StarWarsPeopleResponse.swift
//  RavnChallenge
//
//  Created by Samuel Cornejo on 11/10/20.
//

import Foundation

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
