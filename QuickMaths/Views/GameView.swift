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
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                // Stopwatch Animation for Timer
                ZStack {
                    // Background Circle (Static)
                    Circle()
                        .stroke(Color.white.opacity(0.3), lineWidth: 10)
                        .frame(width: 75, height: 75)
                    
                    // Animated Countdown Circle
                    Circle()
                        .trim(from: 0, to: CGFloat(viewModel.timer) / CGFloat(viewModel.initialTime))
                        .stroke(Color.red, lineWidth: 10)
                        .rotationEffect(.degrees(-90))
                        .frame(width: 75, height: 75)
                        .animation(.linear(duration: 1), value: viewModel.timer)
                    
                    // Time Text
                    Text("\(viewModel.timer)")
                        .font(.custom("American Typewriter", size: 20))
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                // Display current question
                if let currentQuestion = viewModel.currentQuestion {
                    QuestionCard(question: currentQuestion) { answer in
                        viewModel.checkAnswer(answer)
                        viewModel.moveToNextQuestion()
                    }
                }
                
                Spacer()
                
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
            .navigationBarBackButtonHidden(true)
            .padding()
            .foregroundColor(.white)
        }
    }
}

struct QuestionCard: View {
    var question: Question
    var onSelectAnswer: (Int) -> Void

    var body: some View {
        VStack(alignment: .leading) {
            Text(question.text)
                .font(.system(size: 24, weight: .bold))
                .padding(.bottom, 5)

            ForEach(0..<question.options.count, id: \.self) { i in
                Button(action: {
                    onSelectAnswer(i)
                }) {
                    Text("\(question.options[i])")
                        .font(.system(size: 18))
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
