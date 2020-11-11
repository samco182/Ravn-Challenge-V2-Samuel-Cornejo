//
//  PersonCell.swift
//  RavnChallenge
//
//  Created by Samuel Cornejo on 11/10/20.
//

import SwiftUI

struct PersonCell: View {
    // MARK: Variables Declaration
    let name: String?
    let shortDescription: String

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                VStack(alignment: .leading) {
                    Text(name ?? "")
                        .textStyle(.h2Default)

                    Text(shortDescription)
                        .textStyle(.p1LowEmphasis)
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
        PersonCell(name: "Luke Skywalker", shortDescription: "Human from Tatooine")
    }
}
