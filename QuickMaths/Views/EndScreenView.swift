//
//  EndScreenView.swift
//  QuickMaths
//
//  Created by Taylor Tran on 11/7/24.
//

import Foundation
import SwiftUI

struct EndScreenView: View {
    @EnvironmentObject var viewModel: GameViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                Text("Game Over")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                Text("Correct Answers: \(viewModel.correctAnswers) / \(viewModel.allQuestions.count)")
                    .font(.title2)
                    .foregroundColor(.white)
                
                Text("Score: \(viewModel.score, specifier: "%.2f")%")
                    .font(.title2)
                    .foregroundColor(.white)
                
                NavigationLink {
                    WelcomeView()
                } label: {
                    Text("Return to Home")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .foregroundColor(.black)
                
            }
            .padding()
            .background(Color.black)
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    NavigationView {
        EndScreenView()
    }
    .environmentObject(GameViewModel(
        difficulty: 1,
        questionCount: 10)
    )
}
