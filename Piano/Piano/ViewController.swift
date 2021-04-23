//
//  ViewController.swift
//  Piano
//
//  Created by Jose Caraballo on 1/2/21.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var audioPlayer : AVAudioPlayer!
    
    let soundsArray = ["c1", "c1s", "d1", "d1s", "e1", "f1", "f1s", "g1", "g1s", "a1", "a1s", "b1", "c2"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func playSound(_ sender: UIButton) {
        
        
        let idK = sender.tag
        
        let fileName = soundsArray[idK-1]
        print("Ha pulsado la tecla \(idK)")
        
        if let soundURL : URL = Bundle.main.url(forResource: fileName, withExtension: "mp3")
        {
            print(soundURL)
            do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            } catch {
                let controller = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel )
                
                controller.addAction(action)
            }
            
            audioPlayer.play()
            
        }
    }
    
}

