//
//  SectionHeader.swift
//  RavnChallenge
//
//  Created by Samuel Cornejo on 11/11/20.
//

import SwiftUI

struct SectionHeader: View {
    // MARK: Variables Declaration
    let title: String

    var body: some View {
        Text(title)
            .textStyle(.headerDefault)
            .padding(.horizontal, 16)
            .padding(.top, 32)
            .padding(.bottom, 8)
    }
}

struct SectionHeader_Previews: PreviewProvider {
    static var previews: some View {
        SectionHeader(title: "General Information")
    }
}
