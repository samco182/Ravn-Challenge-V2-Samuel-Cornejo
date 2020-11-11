//
//  PersonDetailView.swift
//  RavnChallenge
//
//  Created by Samuel Cornejo on 11/11/20.
//

import SwiftUI

struct PersonDetailView: View {
    // MARK: Variables Declaration
    let person: Person

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 0) {
                SectionHeader(title: "General Information")

                DataCell(title: "Eye Color", value: person.eyeColor?.capitalized ?? "N/A")

                DataCell(title: "Hair Color", value: person.hairColor?.capitalized ?? "N/A")

                DataCell(title: "Skin Color", value: person.skinColor?.capitalized ?? "N/A")

                DataCell(title: "Birth Year", value: person.birthYear ?? "N/A")

                if !person.vehicles.isEmpty {
                    SectionHeader(title: "Vehicles")

                    VStack(spacing: 0) {
                        ForEach(person.vehicles, id: \.id) { vehicle in
                            DataCell(title: vehicle.name ?? "")
                        }
                    }
                }
            }
        }
        .navigationBarTitle(person.name ?? "", displayMode: .inline)
    }
}

struct PersonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let person = Person(id: "1",
                            name: "Luke Skywalker",
                            eyeColor: "Blue",
                            hairColor: "Blond",
                            skinColor: "Fair",
                            birthYear: "19BBY",
                            vehicleConnection: .init(vehicles:[.init(id: "1", name: "Snowspeeder"),
                                                               .init(id: "3", name: "Imperial Speeder Bike")]))

        NavigationView {
            PersonDetailView(person: person)
        }
    }
}
