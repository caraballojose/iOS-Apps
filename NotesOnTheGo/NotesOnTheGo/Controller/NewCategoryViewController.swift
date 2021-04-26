//
//  NewCategoryViewController.swift
//  NotesOnTheGo
//
//  Created by Jose Caraballo on 13/3/21.
//

import UIKit
import CoreData

class NewCategoryViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!

    @IBOutlet var colorSliders: [UISlider]!
    @IBOutlet var colorLabels: [UILabel]!
    
    let colorKeys = ["R", "G", "B", "A"]
    
    let imagePicker = UIImagePickerController()
    
    var backColor = UIColor()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
        
        //como Imageview no puede invocar Action, a;adinos un gesture recognizer
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
       self.imageView.isUserInteractionEnabled = true
       self.imageView.addGestureRecognizer(tapGestureRecognizer)
        
        repaintBackground()
        
        imagePicker.delegate = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func sliderMoved(_ sender: UISlider) {
        
        colorLabels[sender.tag].text = "\(colorKeys[sender.tag]): \(Int(sender.value*255.0))"
        if colorLabels[0].text == "R: 0" && colorLabels[1].text == "G: 0" {
            for label in colorLabels {
                label.textColor = UIColor.white
            }
        } else {
            for label in colorLabels {
                label.textColor = UIColor.black
            }
        }
        repaintBackground()
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        
        let category = Category(context: context)
        category.title = textField.text!
        category.colorHex = backColor.toHex
        category.image = imageView.image?.pngData()
        
        do{
            try context.save()
        }catch {
            print("Error al guardar la categoría en CD")
        }
        dismiss(animated: true, completion : {
            self.navigationController?.navigationBar.isHidden = false
            self.navigationController?.popViewController(animated: true)
        })
        
    }
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion : {
            self.navigationController?.navigationBar.isHidden = false
            self.navigationController?.popViewController(animated: true)
        })
    }
    
    @objc func imageTapped() {
        self.imagePicker.allowsEditing = false
        
        let controller = UIAlertController(title: "Selecciona un ruta", message: "", preferredStyle: .actionSheet)
        controller.addAction(UIAlertAction(title: "Camara", style: .default, handler: { (action) in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        controller.addAction(UIAlertAction(title: "Album de Fotos", style: .default, handler: { (action) in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        controller.addAction(UIAlertAction(title: "Galeria", style: .default, handler: { (action) in
            self.imagePicker.sourceType = .savedPhotosAlbum
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        self.present(controller, animated: true, completion: nil)
    }
    
    func repaintBackground() {
        backColor = UIColor(red: CGFloat(colorSliders[0].value), green: CGFloat(colorSliders[1].value), blue: CGFloat(colorSliders[2].value), alpha: CGFloat(colorSliders[3].value))
        
        self.view.backgroundColor = backColor
    }
}


extension NewCategoryViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension NewCategoryViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
