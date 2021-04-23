//
//  ViewController.swift
//  NotesOnTheGo
//
//  Created by Jose Caraballo on 23/2/21.
//

import UIKit
import RealmSwift

class CategoriesViewController: UICollectionViewController {
    
    var categories : Results<Category>!
    
    var selectedCategory : Int = 0
     
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.blue,
            NSAttributedString.Key.font : UIFont(name: "Papyrus", size: 26.0) ?? UIFont.systemFont(ofSize: 26.0)
        ]
        navigationController?.navigationBar.backgroundColor = UIColor.cyan
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Hola soy Did appear")
    }

    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryViewControllerCollectionViewCell
        
        let category = categories[indexPath.row]
        
        cell.labelCell.text = category.title
        cell.imageView.image = UIImage(data: category.image!)
        cell.imageView.contentMode = .scaleAspectFit
        cell.imageView.layer.borderColor = UIColor(hex: category.colorHex!)?.cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 15
        cell.imageView.backgroundColor = UIColor(hex: category.colorHex!)
        return cell  
    }

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //selectedCategory = indexPath.row
        //print("Seleccionaste la categoria \(categoryArray[selectedCategory].title!)")
    }
  
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowNoteList" {
            print("entraste a las notas")
            let destinationVC = segue.destination as! NotesTableViewController
            if let indexPath = collectionView.indexPathsForSelectedItems?[0] {
                selectedCategory = indexPath.row
                destinationVC.selectedCategory = categories[indexPath.row]
            }
            //destinationVC.selectedCategory = categoryArray[self.selectedCategory]
        }
    }
    
    func loadCategories() {
        
        categories = realm.objects(Category.self)
        
        
    }
    
    
}


