//
//  PeopleListView.swift
//  RavnChallenge
//
//  Created by Samuel Cornejo on 11/10/20.
//

import SwiftUI

struct PeopleListView: View {
    // MARK: Variables Declaration
    @ObservedObject var provider: StarWarsPeopleProvider

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(provider.people) { person in
                        NavigationLink(destination: PersonDetailView(person: person)) {
                            PersonCell(name: person.name, shortDescription: person.shortDescription)
                                .onAppear {
                                    provider.fetchMorePeople(after: person)
                                }
                        }
                    }
                }

                LoadingCell(isActive: $provider.isLoading)
                NoticeCell(isActive: $provider.requestDidFail)
            }
            .navigationBarTitle("People", displayMode: .inline)
            .navigationBarStyle(.ravnStyle)
            .onAppear(perform: provider.fetchPeople)
        }
    }
}

struct PeopleListView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleListView(provider: StarWarsPeopleProvider())
    }
}
