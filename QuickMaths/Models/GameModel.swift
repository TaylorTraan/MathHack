//
//  GameModel.swift
//  QuickMaths
//
//  Created by Taylor Tran on 9/26/24.
//

import Foundation

struct GameModel {
    private(set) var timer: Int // Timer in seconds, set dynamically
    private(set) var questions: [Question]
    private(set) var isOver: Bool = false
    private(set) var correctAnswers: Int = 0 // Track correct answers
    
    var timerValue: Int { return timer }
    
    init(timer: Int = 60, difficulty: Int = 1, questionCount: Int = 10) {
        self.timer = timer
        self.questions = GameModel.generateQuestions(difficulty: difficulty, count: questionCount)
    }
    
    // Updates the game timer each second and checks if time has run out
    mutating func updateGameStatus() {
        if timer == 0 {
            isOver = true
        } else {
            timer -= 1
        }
    }
    
    // Marks a question as correctly answered and increments score
    mutating func markCorrectAnswer() {
        correctAnswers += 1
    }
    
    // Calculate score percentage based on correct answers
    func calculateScore() -> Double {
        guard !questions.isEmpty else { return 0.0 }
        return (Double(correctAnswers) / Double(questions.count)) * 100
    }
    
    // Static function to generate questions based on difficulty level
    private static func generateQuestions(difficulty: Int, count: Int) -> [Question] {
        var questions: [Question] = []
        
        for _ in 1...count {
            let question: Question
            
            switch difficulty {
            case 1:
                question = Question.generateSingleDigitAddition()
            case 2:
                question = Question.generateDoubleDigitOperation()
            case 3:
                question = Question.generateTripleDigitOperation()
            case 4:
                question = Question.generateIntermediateFractionOperation()
            case 5:
                question = Question.generateComplexMentalMath()
            default:
                question = Question.generateSingleDigitAddition()
            }
            
            questions.append(question)
        }
        
        return questions
    }
}

struct Question {
    var text: String
    var correctAnswerIndex: Int
    var options: [Int]
    
    // Generate simple single-digit addition
    static func generateSingleDigitAddition() -> Question {
        let a = Int.random(in: 0...9)
        let b = Int.random(in: 0...9)
        let answer = a + b
        return createQuestion(text: "\(a) + \(b)", answer: answer)
    }
    
    // Generate double-digit or single-digit multiplication/division
    static func generateDoubleDigitOperation() -> Question {
        let operations = ["*", "/", "+", "-"]
        let operation = operations.randomElement()!
        
        let (text, answer): (String, Int) = {
            let a = Int.random(in: 10...99)
            let b = Int.random(in: 1...9)  // For division, we want a smaller divisor to avoid complex fractions
            switch operation {
            case "*":
                return ("\(a) * \(b)", a * b)
            case "/":
                let dividend = a * b  // Ensures clean division
                return ("\(dividend) / \(b)", a)
            case "+":
                let c = Int.random(in: 10...99)
                return ("\(a) + \(c)", a + c)
            case "-":
                let d = Int.random(in: 10...99)
                let total = a + d  // Ensures a non-negative result for subtraction
                return ("\(total) - \(d)", a)
            default:
                return ("\(a) + \(b)", a + b) // Fallback, though this case shouldn't occur
            }
        }()
        
        return createQuestion(text: text, answer: answer)
    }

    // Generate triple-digit addition/subtraction
    static func generateTripleDigitOperation() -> Question {
        let a = Int.random(in: 100...999)
        let b = Int.random(in: 100...999)
        let operation = Bool.random() ? "+" : "-"
        
        let (text, answer) = operation == "+" ?
            ("\(a) + \(b)", a + b) :
            ("\(a) - \(b)", a - b)
        
        return createQuestion(text: text, answer: answer)
    }

    // Generate intermediate fraction questions
    static func generateIntermediateFractionOperation() -> Question {
        let numerator = Int.random(in: 1...9)
        let denominator = Int.random(in: 2...9)
        let multiplier = Int.random(in: 1...10)
        let answer = (numerator * multiplier) / denominator
        
        let text = "\(numerator * multiplier) / \(denominator)"
        return createQuestion(text: text, answer: answer)
    }

    // Generate difficult mental math questions
    static func generateComplexMentalMath() -> Question {
        let a = Int.random(in: 50...200)
        let b = Int.random(in: 2...20)
        let c = Int.random(in: 1...10)
        let d = Int.random(in: 1...5)
        
        let expressionOptions = [
            ("\(a) + \(b) * \(c)", a + b * c),
            ("\(a) - \(b) * \(c)", a - b * c),
            ("(\(a) + \(b)) / \(d)", (a + b) / d),
            ("\(a) * \(c) + \(b)", a * c + b)
        ]
        
        let (text, answer) = expressionOptions.randomElement()!
        return createQuestion(text: text, answer: answer)
    }

    
    // Utility function to create a question with answer options
    private static func createQuestion(text: String, answer: Int) -> Question {
        var options = [answer]
        while options.count < 4 {
            let randomOption = Int.random(in: max(answer - 10, 0)...(answer + 10))
            if !options.contains(randomOption) {
                options.append(randomOption)
            }
        }
        options.shuffle()
        let correctAnswerIndex = options.firstIndex(of: answer) ?? 0
        return Question(text: text, correctAnswerIndex: correctAnswerIndex, options: options)
    }
}

