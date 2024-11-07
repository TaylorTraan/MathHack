//
//  CustomizeGameView.swift
//  QuickMaths
//
//  Created by Taylor Tran on 9/26/24.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var viewModel: GameViewModel
    @State private var isGameOver: Bool = false

    var body: some View {
        VStack {
            // Display remaining time
            Text("Time Left: \(viewModel.timer)")
                .font(.custom("American Typewriter", size: 20))
                .padding()
                .background(Color.white.opacity(0.5))
                .cornerRadius(10)
                .foregroundColor(.black)

            // Display current question
            if let currentQuestion = viewModel.currentQuestion {
                QuestionCard(question: currentQuestion) { answer in
                    viewModel.checkAnswer(answer)
                    viewModel.moveToNextQuestion()
                }
            }

            // End Game when time is up
            NavigationLink(
                destination: EndScreenView()
                    .environmentObject(viewModel),
                isActive: $viewModel.isGameOver,
                label: { EmptyView() }
            )
        }
        .onAppear {
            viewModel.startGame()
        }
        .padding()
        .background(Color.black)
        .foregroundColor(.white)
    }
}

struct QuestionCard: View {
    var question: Question
    var onSelectAnswer: (Int) -> Void

    var body: some View {
        VStack(alignment: .leading) {
            Text(question.text)
                .font(.headline)
                .padding(.bottom, 5)

            ForEach(0..<question.options.count, id: \.self) { i in
                Button(action: {
                    onSelectAnswer(i)
                }) {
                    Text("\(question.options[i])")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(8)
                        .foregroundColor(.black)
                }
            }
        }
        .padding()
        .background(Color.white.opacity(0.6))
        .cornerRadius(10)
    }
}

#Preview {
    GameView()
        .environmentObject(GameViewModel(difficulty: 1, questionCount: 10))
}
