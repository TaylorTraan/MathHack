//
//  WelcomeView.swift
//  QuickMaths
//
//  Created by Taylor Tran on 9/26/24.
//

import SwiftUI

struct WelcomeView: View {
    @State private var chosenTime: String = "60"
    @State private var chosenDifficulty: Int = 1
    @State private var questionCount: Int = 10
    
    @State private var isGameViewActive = false
    @State private var gameViewModel: GameViewModel? // Local instance for GameViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Quick Maths")
                .font(.custom("Marker Felt", size: 50))
                .foregroundColor(Color.white)
            
            Spacer()
            
            VStack(spacing: 15) {
                HStack {
                    Text("Timer:")
                    TextField("Time", text: $chosenTime)
                        .multilineTextAlignment(.center)
                        .frame(width: 50, height: 40)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(10)
                }
                
                HStack {
                    Text("Difficulty:")
                    Picker("Difficulty", selection: $chosenDifficulty) {
                        ForEach(1...5, id: \.self) { level in
                            Text("\(level)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .frame(height: 40)
                .background(.gray)
                .cornerRadius(10)
                
                HStack {
                    Text("Questions:")
                    TextField("Number", value: $questionCount, formatter: NumberFormatter())
                        .multilineTextAlignment(.center)
                        .frame(width: 50, height: 40)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(10)
                }
            }
            .font(.custom("American Typewriter", size: 16))
            .foregroundColor(.white)
            
            Spacer()
            
            Button("Start Game") {
                gameViewModel = GameViewModel(
                    timer: Int(chosenTime) ?? 60,
                    difficulty: chosenDifficulty,
                    questionCount: questionCount
                )
                isGameViewActive = true
            }
            .padding()
            .foregroundColor(.black)
            .background(Color.white)
            .cornerRadius(8)
            
            NavigationLink(
                destination: GameView()
                    .environmentObject(gameViewModel ?? GameViewModel(
                        difficulty: 1, questionCount: 10)
                    ),
                isActive: $isGameViewActive,
                label: { EmptyView() }
            )
            
            Spacer()
        }
        .padding()
        .background(Color.black)
    }
}


// Define a custom color extension for pastel blue
extension Color {
    static let pastelBlue = Color(red: 0.7, green: 0.9, blue: 1.0)
}

#Preview {
    NavigationView {
        WelcomeView()
    }
    .environmentObject(GameViewModel(
        difficulty: 1,
        questionCount: 10)
    )
}

