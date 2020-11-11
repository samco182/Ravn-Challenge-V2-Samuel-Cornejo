//
//  LoadingCell.swift
//  RavnChallenge
//
//  Created by Samuel Cornejo on 11/10/20.
//

import SwiftUI

struct LoadingCell: View {
    // MARK: Variables Declaration
    @Binding var isActive: Bool

    var body: some View {
        if isActive {
            LazyHStack(spacing: 8) {
                ProgressView()

                Text("Loading")
                    .textStyle(.h2LowEmpashis)
            }
            .padding(.top, 16)
        }
    }
}

struct LoadingCell_Previews: PreviewProvider {
    static var previews: some View {
        LoadingCell(isActive: .constant(true))
    }
}
