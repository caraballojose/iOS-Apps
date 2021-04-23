//
//  Question.swift
//  QuizApp
//
//  Created by Jose Caraballo on 4/2/21.
//

import Foundation

class Question : CustomStringConvertible, Codable {
    
    let question : String
    let answer: Bool
    
  /*  enum CodingKeys : String, CodingKey {
        case questionText = "question"
        case answer = "answer"
    }
   */
    var description : String {
        
        let respuesta = (answer ? "Verdadero":"Falso")
        return """
        Pregunta:
        -------------------------
            - \(question)
        Respuesta: \(respuesta)
        """
    }
    
    init(text: String, correctAnswer: Bool) {
        
        self.question = text
        self.answer = correctAnswer
        
    }

}

struct QuestionsBank : Codable {
    var questions : [Question]
}
