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
    static let headerDefault = TextStyle(font: .system(size: 17, weight: .bold), color: .darkText)
    static let headerLowEmphasis = TextStyle(font: .system(size: 17, weight: .bold), color: .lightText)
    static let headerHighEmphasis = TextStyle(font: .system(size: 17, weight: .bold), color: .emphasisText)
    static let paragraphDefault = TextStyle(font: .system(size: 14), color: .darkText)
    static let paragraphLowEmphasis = TextStyle(font: .system(size: 14), color: .lightText)
}

extension View {
    func textStyle(_ style: TextStyle) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}
