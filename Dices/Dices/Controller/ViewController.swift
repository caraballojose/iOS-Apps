//
//  ViewController.swift
//  Dices
//
//  Created by Jose Caraballo on 26/1/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageViewDiceLeft: UIImageView!
    
    @IBOutlet weak var imageViewDiceRight: UIImageView!
    
    @IBOutlet weak var chanceView: UILabel!
    
    var randomDiceIndexLeft : Int = 0
    
    var randomDiceIndexRight : Int = 0
    
    let chanceNumber = ["Chance: 5", "Chance: 4", "Chance: 3", "Chance: 2", "Chance: 1", "Chance: 0"]
    
    let diceImages : [String] = ["dice1", "dice2", "dice3", "dice4", "dice5", "dice6"]
    
    let nFaces : UInt32
    
    var chances = 0
    
    required init?(coder aDecoder: NSCoder) {
        
        nFaces = UInt32(diceImages.count)
        super.init(coder: aDecoder)
        
    } 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        generateRandomDices()
    }

    @IBAction func rollPressed(_ sender: UIButton) {
        
        if chances == 6 {
            generateAlert(msg: """
                                                        Se han agotado
                                                        tus oportunidades
                                                        """, Tl: "Game Over")
        } else if randomDiceIndexRight != randomDiceIndexLeft {
            
            generateRandomDices()
            chanceView.text = chanceNumber[chances]
            chances += 1
            
        }
        
        if randomDiceIndexRight == randomDiceIndexLeft {
                
            generateAlert(msg: "Enhorabuena!", Tl: "FELICIDADES LO HAS LOGRADO!!!")
            chances = 0
                
            }
        
    }

    
    func generateAlert(msg: String?, Tl: String?) {
        
        let controller = UIAlertController.init(title: Tl, message: msg, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel) { (action) in }
        
        controller.addAction(action)
        
        self.show(controller, sender: nil)
        
    }
    
    func generateRandomDices() {
        
        randomDiceIndexLeft = Int(arc4random_uniform(nFaces))
        
        randomDiceIndexRight = Int(arc4random_uniform(nFaces))
        
        UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions.curveEaseInOut) {
            
            self.imageViewDiceRight.transform = CGAffineTransform(scaleX: 0.6, y: 0.6).concatenating(CGAffineTransform(rotationAngle:CGFloat.pi/2)).concatenating(CGAffineTransform(translationX: 120, y:120))
         
            self.imageViewDiceLeft.transform = CGAffineTransform(scaleX: 0.6, y: 0.6).concatenating(CGAffineTransform(rotationAngle:CGFloat.pi/2)).concatenating(CGAffineTransform(translationX: -120, y:120))
            
            self.imageViewDiceRight.alpha = 0.0
            
            self.imageViewDiceLeft.alpha = 0.0

            
        } completion: { _ in
            
            self.imageViewDiceRight.transform = CGAffineTransform.identity
            
            self.imageViewDiceLeft.transform = CGAffineTransform.identity
            
            self.imageViewDiceRight.alpha = 1.0
            
            self.imageViewDiceLeft.alpha = 1.0
            
            self.imageViewDiceLeft.image = UIImage(named: self.diceImages[self.randomDiceIndexLeft])
            
            self.imageViewDiceRight.image = UIImage(named: self.diceImages[self.randomDiceIndexRight])

        }

    }
    
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
        if motion == .motionShake {
            generateRandomDices()
        }
        
    }
    
}

