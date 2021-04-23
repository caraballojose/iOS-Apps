//
//  RegisterViewController.swift
//  ChatApp
//
//  Created by Jose Caraballo on 8/4/21.
//

import UIKit
import Firebase
import ProgressHUD

class RegisterViewController: UIViewController {
    
    let backG : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.alpha = 0.8
        iv.image = #imageLiteral(resourceName: "puente")
        return iv
    }()
    
    let emailField : UITextField = {
        let tf = UITextField()
        tf.keyboardType = .emailAddress
        tf.borderStyle = .roundedRect
        tf.keyboardAppearance = .dark
        tf.backgroundColor = .white
        tf.placeholder = "Email"
        //tf.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [.foregroundColor: UIColor(white: 1, alpha: 1)])
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 12)
        tf.leftView = spacer
        tf.leftViewMode = .always
        return tf
    }()
    
    let passwordField : UITextField = {
        let tf = UITextField()
        tf.isSecureTextEntry = true
        tf.borderStyle = .roundedRect
        tf.keyboardAppearance = .dark
        tf.backgroundColor = .white
        tf.placeholder = "Password"
        //tf.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.9)])
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 12)
        tf.leftView = spacer
        tf.leftViewMode = .always
        return tf
    }()
    
    let repeatpasswordField : UITextField = {
        let tf = UITextField()
        tf.isSecureTextEntry = true
        tf.borderStyle = .roundedRect
        tf.keyboardAppearance = .dark
        tf.backgroundColor = .white
        tf.placeholder = "Repeat Password"
        //tf.attributedPlaceholder = NSAttributedString(string: "Repeat Password", attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.9)])
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 12)
        tf.leftView = spacer
        tf.leftViewMode = .always
        return tf
    }()
    
    let switchBotton : UISwitch = {
        let sw = UISwitch()
        sw.preferredStyle = .sliding
        sw.onTintColor = .blue
        sw.isOn = false
        return sw
    }()
    
    let termsLabel : UILabel = {
        let lb = UILabel()
        lb.text = "Debe aceptar nuestros terminos y condiciones!"
        lb.textColor = .white
        lb.font = UIFont.boldSystemFont(ofSize: 14)
        lb.adjustsFontSizeToFitWidth = true
        lb.minimumScaleFactor = 0.4
        return lb
    }()
    
    let signInBotton : UIButton = {
        let bt = UIButton()
        bt.setTitle("Registrarse", for: .normal)
        bt.backgroundColor = .blue
        bt.addTarget(self, action: #selector(registerPressed), for: .touchUpInside)
        return bt
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
        configureUI()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
              
    }
    
    func configureUI() {
        navigationController?.navigationBar.tintColor = .white
        navigationItem.title = "Registration"
        view.addSubview(backG)
        backG.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        let stack = UIStackView(arrangedSubviews: [emailField,passwordField,repeatpasswordField,signInBotton])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.spacing = 8
        emailField.setDimensions(height: 50, width: view.frame.width)
        passwordField.setDimensions(height: 50, width: view.frame.width)
        repeatpasswordField.setDimensions(height: 50, width: view.frame.width)
        signInBotton.setDimensions(height: 50, width: view.frame.width)
        
        view.addSubview(stack)
        stack.anchor(left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 16, paddingRight: 16)
        stack.center(inView: view)
        
        let stackTerms = UIStackView(arrangedSubviews: [switchBotton,termsLabel])
        stackTerms.axis = .horizontal
        stackTerms.distribution = .fillProportionally
        stackTerms.spacing = 8
        
        view.addSubview(stackTerms)
        stackTerms.anchor(top: stack.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 8, paddingLeft: 16, paddingRight: 16)
        stackTerms.centerX(inView: view)
    }
    
    //MARK:- Actions
    
    @objc func registerPressed() {
        
        guard passwordField.text == repeatpasswordField.text && passwordField.text != "" && repeatpasswordField.text != "" else {
            callAlert(title: "Error", msg: "El password no coincide!")
            return
        }
        
        guard let email = emailField.text, let pass = passwordField.text else {
            return
        }
        
        guard switchBotton.isOn else {
            callAlert(title: "Alerta", msg: "Debe aceptar nuestros terminos y condiciones.")
            return
        }
        ProgressHUD.show()
        Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
            if error != nil{
                self.callAlert(title: "Error", msg: error!.localizedDescription)
            }else{
                print("Usuario agregado con exito")
                let chatVC = ChatViewController()
                ProgressHUD.dismiss()
                self.navigationController?.pushViewController(chatVC, animated: true)
            }
        }
        
    }
    
    func callAlert(title: String, msg: String, act: Bool = true) {
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel) { (action) in
        }
        if !act {
            alert.addAction(action)
        }
        self.present(alert, animated: true)
        guard act else {
            return
        }
        // change to desired number of seconds (in this case 5 seconds)
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when){
          // your code with delay
        alert.dismiss(animated: true, completion: nil)
        }
    }
    
    func cleanFields() {
        emailField.text = ""
        passwordField.text = ""
        repeatpasswordField.text = ""
        switchBotton.isOn = false
    }
  
    
}
