//
//  ViewController.swift
//  QuizApp
//
//  Created by Jose Caraballo on 1/2/21.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var labelQuestion: UILabel!
    
    @IBOutlet weak var labelQuestionNumber: UILabel!
    
    @IBOutlet weak var labelScore: UILabel!
    
    @IBOutlet weak var progressBar: UIView!
    
    var currentScore = 0
    
    var currentQuestionID = 0
    
    var correctQuestionsAnswered = 0
    
    var currentQuestion : Question!
    
    let factory = QuestionFactory()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        startGame()
        
    }
    
    func startGame() {
        currentScore = 0
        currentQuestionID = 0
        correctQuestionsAnswered = 0
        factory.questionsBank.questions.shuffle()
        askNextQuestion()
        updateUIElements()
    }
    
    func askNextQuestion() {
        
        if let newQuestion = factory.getQuestionAt(index: currentQuestionID){
            
            self.currentQuestion = newQuestion
            self.labelQuestion.text = self.currentQuestion.question
            self.currentQuestionID += 1
            
        } else {
            // Game Over
            gameOver()
        }
    }

    func gameOver() {
        //cuando no hay mas preguntas
        let controller = UIAlertController(title: "Fin de la partida!", message: "Has acertado \(correctQuestionsAnswered) / \(currentQuestionID). Prueba otra vez!", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (_) in
            self.startGame()
        }
        controller.addAction(action)
        present(controller, animated: true, completion: nil)
    }
    
    func  updateUIElements() {
        self.labelScore.text = "Score: \(currentScore)"
        self.labelQuestionNumber.text = "\(currentQuestionID) / \(self.factory.questionsBank.questions.count)"
        
        for contrain in self.progressBar.constraints {
            
            if contrain.identifier == "barWidth"
            {
                contrain.constant = CGFloat((self.view.frame.width)/CGFloat(self.factory.questionsBank.questions.count))*CGFloat(self.currentQuestionID)
            }
        }
        
        
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        var isCorrect : Bool
        
        if sender.tag == 1 {
            //Boton true
            isCorrect = (self.currentQuestion.answer == true)
            
        } else {
            //Boton Else
            isCorrect = (self.currentQuestion.answer == false)
        }
        
        var msg = "Has fallado =("
        
        
        if isCorrect {
            self.correctQuestionsAnswered += 1
            msg =  "Enhorabuena!!"
            self.currentScore += 100
            ProgressHUD.colorAnimation = .green
            ProgressHUD.showSucceed(msg)
            
        } else {
            ProgressHUD.colorAnimation = .red
            ProgressHUD.showFailed(msg)
        }
        
        self.askNextQuestion()
        self.updateUIElements()
        
        /*
        let aController = UIAlertController (title: msg, message: "...", preferredStyle: .alert)
        
        let action = UIAlertAction (title: "OK", style: .default) { (_) in
            
        }
        
        aController.addAction(action)
        present(aController, animated: true, completion: nil)
         */
        
        
      
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func generateQuestion() -> String {
        let factory = QuestionFactory()
        let question = factory.getRandomQuestions()
        return "\(question)"
    }
    
}

