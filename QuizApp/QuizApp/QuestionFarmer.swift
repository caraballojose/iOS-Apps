//
//  QuestionFarmer.swift
//  QuizApp
//
//  Created by Jose Caraballo on 4/2/21.
//

import Foundation

class QuestionFactory {
    
    var questionsBank : QuestionsBank!
    
    init() {
                //Procesado manual de un plist
      /*  if let path = Bundle.main.path(forResource: "QuestionFarmer", ofType: "plist") {
            
            if let plist = NSDictionary(contentsOfFile: path){
                let questionsData  = plist["Questions"] as! [AnyObject]
                
                for question in questionsData {
                    if let text = question["question"], let ans = question ["answer"] {
                        
                        questions.append(Question(text: text as! String, correctAnswer: ans as! Bool))
                    }
                }
                
                print(questionsData)
            }
            
        }
        */
        
        //Procesado automatico usando Codable
        do {
            
            if let url = Bundle.main.url(forResource: "QuestionBank", withExtension: "plist") {
                let data = try Data(contentsOf: url)
                
                self.questionsBank = try PropertyListDecoder().decode(QuestionsBank.self, from: data)
                
            }
        } catch {
            print(error)
        }
        
    }
    
    func getQuestionAt(index: Int) -> Question? {
        
        if index < 0 || index >= self.questionsBank.questions.count {
            return nil
        } else {
            return self.questionsBank.questions[index]
        }
    }
    
    func getRandomQuestions() -> Question {
        
        let index = Int(arc4random_uniform(UInt32(self.questionsBank.questions.count)))
        return self.questionsBank.questions[index]
        
    }
    
}
