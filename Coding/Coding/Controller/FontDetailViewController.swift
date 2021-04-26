//
//  FontDetailViewController.swift
//  Coding
//
//  Created by Jose Caraballo on 31/1/21.
//

import UIKit

class FontDetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
  
    
    
    var familyname : String = ""
    
    var fonts : [String] = []
    
    @IBOutlet weak var LabelTittle: UILabel!
    
    @IBOutlet weak var pickerFonts: UIPickerView!
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.LabelTittle.text = familyname
        self.LabelTittle.font = UIFont(name: familyname, size: 24)
        
        if fonts.count == 0 {
            
            self.pickerFonts.isHidden = true
            
        }
        
        self.textView.font = UIFont(name: familyname, size: 18.0)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func barButtonPressed(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true)
    }
    
    ///UIPickerVewDataSource Metodos
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return self.fonts.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return fonts[row]
    }
    
    //Delegate
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let font = fonts[row]
        self.textView.font = UIFont(name: font, size: 18.0)
        
    }
    
    
}
