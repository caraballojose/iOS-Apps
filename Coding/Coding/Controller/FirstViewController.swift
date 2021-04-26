//
//  FirstViewController.swift
//  Coding
//
//  Created by Jose Caraballo on 28/1/21.
//

import UIKit

class FirstViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var labelAge: UILabel!
    
    @IBOutlet weak var sliderLabelAge: UISlider!
    
    var varAge = -1
    
    var userName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        varAge = Int(self.sliderLabelAge.value)

        self.labelAge.text = "\(varAge)"
    
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        print("Hemos pulsado la tecla enter")
        
        if let theText = textField.text {
            
            print(theText)
            
            self.userName = theText
            
        }
        
        return true
    }
    
    
    @IBAction func sliderAgeMoved(_ sender: UISlider) {
        
        varAge = Int(sender.value)
        
        labelAge.text = "\(varAge)"
        
        
    }

    
    @IBAction func validateData(_ sender: UIButton) {
        
        if userName == "" {
            callingAlert(tl: "Error!", msg: "Debes completar todos los campos!...")
        } else {
            if userName == "Jose Francisco" {              
            
            
            callingAlert(tl:"Bienvenido!", msg: "puedes ingresar por ser JF!...")
            
                self.view.backgroundColor = UIColor(displayP3Red: 49.0/255.0, green: 237.0/255.0, blue: 94.0/255.0, alpha: 0.7)
            
        } else {
            if varAge >= 18 {
                
                callingAlert(tl: "Bienvenido!", msg: "Puedes pasar a la fiesta por ser mayor de edad")
                
                self.view.backgroundColor = UIColor(displayP3Red: 25.0/255.0, green: 145.0/255.0, blue: 236.0/255.0, alpha: 0.7)
                
            } else {
                              
                callingAlert(tl: "Access Deny!", msg: "Lo Siento no tienes acceso!!!...")
                
                self.view.backgroundColor = UIColor(displayP3Red: 245.0/255.0, green: 30.0/255.0, blue: 60.0/255.0, alpha: 0.7)
                
            }
        }
        }
    }
    
    func callingAlert (tl: String, msg: String) {
        
        let controller = UIAlertController(title: tl, message: msg, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default) { (action) in }
        
        controller.addAction(action)
        
        self.show(controller, sender: nil)
        
    }
    
    

}
