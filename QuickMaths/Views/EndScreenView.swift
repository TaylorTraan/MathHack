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

            Button("Return to Home") {
                presentationMode.wrappedValue.dismiss()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .foregroundColor(.black)
        }
        .padding()
        .background(Color.black)
    }
}
