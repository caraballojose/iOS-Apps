//
// ThirdViewController.swift
// Coding
//
// Created by Jose Caraballo on 28/1/21.
//

import UIKit

class ThirdViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var families: [String] = []
    
    var fonts : [String: [String]] = [:]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        families = UIFont.familyNames.sorted(by: {return $0 < $1})
        
        for font in families {
            
            fonts[font] = UIFont.fontNames(forFamilyName: font)
            
        }
        
        print(families)
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowFontsForFamily" {
            let navController = segue.destination as! UINavigationController
            let destinationVC = navController.topViewController as! FontDetailViewController
            let idx = self.tableView.indexPathForSelectedRow!.row
            
            destinationVC.familyname = self.families[idx]
            destinationVC.fonts = self.fonts[self.families[idx]]!
        }
            
    }
    
    //Metodos del protocolo UITable
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.families.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        cell.textLabel?.text = self.families[indexPath.row]
        cell.textLabel?.font = UIFont(name: families[indexPath.row], size: 22.0)
        
        return cell
    }
    
    // MARK: Metodos del protocolo UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let fontFamily = families[row]
        let familyFonts = fonts[fontFamily]!
        
        print(familyFonts)
       
    }

}
