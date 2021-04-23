//
//  SecondViewController.swift
//  Coding
//
//  Created by Jose Caraballo on 28/1/21.
//

import UIKit

class SecondViewController: UIViewController {
    
    
    @IBOutlet weak var labelNumber: UILabel!
    
    @IBOutlet weak var textViewResult: UITextView!
    
    @IBOutlet weak var stepperLabel: UIStepper!
    
    
    @IBOutlet weak var labelGoldNum: UILabel!
    
    var calculateGoldNum = false
    
    
    var fibonacci : [Int] = [0,1]
    
    var fibId = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        fibId = Int(self.stepperLabel.value)
        
        self.labelNumber.text = "\(fibId)"
        
        generateFibonacci()
    
    }
    
    func generateFibonacci(){
        
        fibonacci = [0,1]
        
        if fibId <= 1 || fibId > 100 {
            return
        }
        
        for i in 2...fibId {
            fibonacci.append(fibonacci[i-1]+fibonacci[i-2])
        }
        
        
        let fibStr : [String] = fibonacci.compactMap({String ($0)})
        let result : String = fibStr.joined(separator: "\n")
        self.textViewResult.text = result
        
    }
   
    
    @IBAction func stepperPressed(_ sender: UIStepper) {
        
        self.fibId = Int(sender.value)
        
        self.labelNumber.text = "\(self.fibId)"
        
        generateFibonacci()
        calculateGoldNumber()
        
    }
    
    
    @IBAction func switchMoved(_ sender: UISwitch) {
        
        calculateGoldNum = sender.isOn
        calculateGoldNumber()
       
        
    }
    
    func calculateGoldNumber() {
        
        if calculateGoldNum {
            
            let last = Double(fibonacci[fibonacci.count-1])
            let previous = Double(fibonacci[fibonacci.count-2])
            let goldNum = last / previous
            
            self.labelGoldNum.text = "\(goldNum)"
            
        } else {
            
            self.labelGoldNum.text = "Ver el número de oro"
            
        }
        
    }
    
    

}
