//
//  RavnChallengeApp.swift
//  RavnChallenge
//
//  Created by Samuel Cornejo on 11/9/20.
//

import SwiftUI

@main
struct RavnChallengeApp: App {
    // MARK: Variables Declaration
    @StateObject var provider = StarWarsPeopleProvider()

    var body: some Scene {
        WindowGroup {
            PeopleListView(provider: provider)
        }
    }
}

struct RavnChallengeApp_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
