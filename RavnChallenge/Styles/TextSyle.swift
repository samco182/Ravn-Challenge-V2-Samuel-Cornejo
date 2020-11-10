//
//  TextSyle.swift
//  RavnChallenge
//
//  Created by Samuel Cornejo on 11/9/20.
//

import SwiftUI

struct TextStyle: ViewModifier {
    // MARK: Variables Declaration
    let font: Font
    let color: Color

    // MARK: Public Methods
    static func designSystem(font: Font, color: Color) -> TextStyle {
        TextStyle(font: font, color: color)
    }

    func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(color)
    }
}

extension TextStyle {
    static let h2Default = TextStyle(font: .system(size: 17, weight: .bold), color: .textDark)
    static let h2LowEmpashis = TextStyle(font: .system(size: 17, weight: .bold), color: .textLight)
    static let h2HighEmphasis = TextStyle(font: .system(size: 17, weight: .bold), color: .textEmphasis)
    static let p1Default = TextStyle(font: .system(size: 14), color: .textDark)
    static let p1LowEmphasis = TextStyle(font: .system(size: 14), color: .textLight)
}

extension View {
    func textStyle(_ style: TextStyle) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}
