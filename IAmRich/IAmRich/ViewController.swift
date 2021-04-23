//
//  ViewController.swift
//  IAmRich
//
//  Created by Jose Caraballo on 24/1/21.
//

import UIKit

class ViewController: UIViewController {
    
    //Properties
    
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var imageLabelDiamond: UIImageView!
    
    @IBOutlet weak var buttonPush: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("Hola que tal!")
    }
    
    
    //Metodos

    @IBAction func ButtonPressed(_ sender: UIButton) {
        /*
        self.labelTitle.text = "Se ha púlsado el botón!"
        self.labelTitle.textColor = UIColor.green
        self.labelTitle.font = UIFont.boldSystemFont(ofSize: 30.0)
        self.imageLabelDiamond.image = UIImage(named: "diamond-image")
        */
        
        let controller = UIAlertController.init(title: "I'm Rich", message: """
                                                        I'm rich,
                                                        I deserve it.
                                                        I'm good,
                                                        healthy and successful
                                                        """, preferredStyle: .alert)
        let action = UIAlertAction(title: "Aceptar", style: .default) { (action) in
            print("He púlsado el botón aceptar!.")
        }
        
        controller.addAction(action)
        
        self.show(controller, sender: nil)
    }
    
}

