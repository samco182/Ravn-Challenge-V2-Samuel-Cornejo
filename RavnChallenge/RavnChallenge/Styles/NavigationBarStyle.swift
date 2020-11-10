//
//  NavigationBarStyle.swift
//  RavnChallenge
//
//  Created by Samuel Cornejo on 11/10/20.
//

import SwiftUI

struct NavigationBarStyle: ViewModifier {
    // MARK: Initializer
    init(backgroundColor: UIColor?, titleColor: UIColor) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = backgroundColor
        appearance.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 17, weight: .bold),
                                          .foregroundColor: titleColor]

        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().tintColor = .white
    }

    // MARK: Public Methods
    func body(content: Content) -> some View {
        content
    }
}

extension NavigationBarStyle {
    static let ravnStyle = NavigationBarStyle(backgroundColor: .ravnBlack, titleColor: .white)
}

extension View {
    func navigationBarStyle(_ style: NavigationBarStyle) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}
