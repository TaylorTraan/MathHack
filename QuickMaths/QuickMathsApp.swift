//
//  QuickMathsApp.swift
//  QuickMaths
//
//  Created by Taylor Tran on 9/26/24.
//

import SwiftUI

@main
struct QuickMathsApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView{
                WelcomeView()
            }
            .environmentObject(GameViewModel(
                difficulty: 1,
                questionCount: 10)
            )
        }
    }
}
