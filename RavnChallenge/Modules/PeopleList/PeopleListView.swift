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
                    ForEach(provider.people, id: \.id) { person in
                        PersonCell(name: person.name, shortDescription: person.shortDescription)
                    }

                    LoadingCell(isActive: $provider.isLoading)
                    NoticeCell(isActive: $provider.requestDidFail)
                }
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
