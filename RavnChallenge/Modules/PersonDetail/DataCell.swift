//
//  DataCell.swift
//  RavnChallenge
//
//  Created by Samuel Cornejo on 11/11/20.
//

import SwiftUI

struct DataCell: View {
    // MARK: Variables Declaration
    let title: String
    let value: String

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text(title)
                    .textStyle(.h2LowEmpashis)

                Spacer(minLength: 16)

                Text(value)
                    .textStyle(.h2Default)
                    .padding(.trailing, 16)
            }

            Divider()
        }
        .padding([.leading, .top], 16)
    }

    // MARK: Initializer
    init(title: String, value: String = "") {
        self.title = title
        self.value = value
    }
}

struct DataCell_Previews: PreviewProvider {
    static var previews: some View {
        DataCell(title: "Eye Color", value: "Blue")
    }
}
