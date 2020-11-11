//
//  PersonCell.swift
//  RavnChallenge
//
//  Created by Samuel Cornejo on 11/10/20.
//

import SwiftUI

struct PersonCell: View {
    // MARK: Variables Declaration
    let person: Person

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                VStack(alignment: .leading) {
                    Text(person.name ?? "")
                        .textStyle(.headerDefault)

                    Text(person.shortDescription)
                        .textStyle(.paragraphLowEmphasis)
                }

                Spacer(minLength: 16)

                Image(systemName: "chevron.right")
                    .imageScale(.small)
                    .padding(.trailing, 24)
                    .foregroundColor(Color(UIColor.label))
            }

            Divider()
        }
        .padding([.leading, .top], 16)
    }
}

struct PersonCell_Previews: PreviewProvider {
    static var previews: some View {
        let person = Person(id: "1",
                            name: "Luke Skywalker",
                            eyeColor: "Blue",
                            hairColor: "Blond",
                            skinColor: "Fair",
                            birthYear: "19BBY",
                            vehicleConnection: .init(vehicles:[.init(id: "1", name: "Snowspeeder"),
                                                               .init(id: "3", name: "Imperial Speeder Bike")]))

        PersonCell(person: person)
    }
}
