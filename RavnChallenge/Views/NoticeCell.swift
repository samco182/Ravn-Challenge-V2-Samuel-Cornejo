//
//  NoticeCell.swift
//  RavnChallenge
//
//  Created by Samuel Cornejo on 11/11/20.
//

import SwiftUI

struct NoticeCell: View {
    // MARK: Variables Declaration
    @Binding var isActive: Bool

    var body: some View {
        if isActive {
            Text("Failed to Load Data")
                .textStyle(.h2HighEmphasis)
                .padding(16)
        }
    }
}

struct NoticeCell_Previews: PreviewProvider {
    static var previews: some View {
        NoticeCell(isActive: .constant(true))
    }
}
