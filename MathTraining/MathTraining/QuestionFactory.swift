//
//  QuestionFactory.swift
//  MathTraining
//
//  Created by Jose Caraballo on 18/2/21.
//

import Foundation


class QuestionFactory {
    
    private var questions = [Question]()
    private(set) var score = 0
    
    

    init() {
        self.addNewQuestion()
    }
    
    func addNewQuestion() {
        questions.insert(createQuestion(), at: 0)
    }
    
    func restarGame() {
        self.score = 0
        self.questions.removeAll()
        self.addNewQuestion()
    }
    
    func getQuestion(position: Int) -> Question? {
        
        if position < 0 || position>=questions.count {
            return nil
        }
        
        return self.questions[position]
    }
    
    func updateQuestion(at index: Int, with answer: Int) {
        questions[index].userAnswer = answer
    }
    
    func validateQuestion (at index: Int) {
        if self.questions[index].userAnswer == self.questions[index].answer{
            self.score += 100
        }
    }
    
    func getNumberOfQuestion() -> Int {
        return self.questions.count
    }
    
    func createQuestion() -> Question {
        
        var question = ""
        var correctAnswer = 0
        
        while  true {
            let firsNumber = Int.random(in: 0...9)
            let secondNumber = Int.random(in: 0...9)
            
            if Bool.random(){
                
                let result = firsNumber + secondNumber
                if result < 10 {
                    question = "\(firsNumber) + \(secondNumber)"
                    correctAnswer = result
                    break
                }
            } else {
                let  result = firsNumber - secondNumber
                if result >= 0 {
                    question = "\(firsNumber) - \(secondNumber)"
                    correctAnswer = result
                    break
                }
            }
            
        } // end While
        return Question(text: question, answer: correctAnswer, userAnswer: nil)
    } // end create Question
    
    
}

