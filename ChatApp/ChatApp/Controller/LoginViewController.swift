//
//  LoginViewController.swift
//  ChatApp
//
//  Created by Jose Caraballo on 8/4/21.
//

import UIKit
import Firebase
import ProgressHUD

class LoginViewController: UIViewController {
    
    let backG : UIImageView = {
        
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.alpha = 0.8
        iv.image = #imageLiteral(resourceName: "city")
        
        return iv
    }()
    
    let userField : UITextField = {
        
        let tf = UITextField()
        tf.keyboardType = .emailAddress
        tf.borderStyle = .roundedRect
        tf.keyboardAppearance = .dark
        tf.backgroundColor = .white
        tf.placeholder = "Email"
        //tf.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.9)])
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 12)
        tf.leftView = spacer
        tf.leftViewMode = .always
        return tf
    }()
    
    let passwordField : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.borderStyle = .roundedRect
        tf.keyboardAppearance = .dark
        tf.backgroundColor = .white
        //tf.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.9)])
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 12)
        tf.leftView = spacer
        tf.leftViewMode = .always
        return tf
    }()
    
    let loginBotton : UIButton = {
        let bt = UIButton()
        bt.setTitle("Entrar", for: .normal)
        bt.backgroundColor = .blue
        bt.alpha = 0.6
        bt.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        return bt
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .white
        navigationItem.title = "Log In"
        view.addSubview(backG)
        backG.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        let stack = UIStackView(arrangedSubviews: [userField,passwordField,loginBotton])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.spacing = 8
        userField.setDimensions(height: 50, width: view.frame.width)
        passwordField.setDimensions(height: 50, width: view.frame.width)
        loginBotton.setDimensions(height: 50, width: view.frame.width)
        
        view.addSubview(stack)
        stack.anchor(left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 16, paddingRight: 16)
        stack.center(inView: view)
    }
    
    
    //MARK:- Actions
    
    @objc func logIn() {
        
        guard passwordField.text != "" && userField.text != "" else {
            callAlert(title: "", msg: "Complete todos los campos")
            return
        }
        
        guard let email = userField.text, let pass = passwordField.text else {
            return
        }
    
        ProgressHUD.show()
        
        Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
            
            if error != nil {
                self.callAlert(title: "Error al intentar ingresar", msg: error!.localizedDescription, act: false)
                ProgressHUD.dismiss()
            } else {
                print("Usuario logeado")
                ProgressHUD.dismiss()
                self.navigationController?.pushViewController(ChatViewController(), animated: true)
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
        // change to desired number of seconds (in this case 5 seconds)
        guard act else {
            return
        }
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when){
          // your code with delay
        alert.dismiss(animated: true, completion: nil)
        }
    }
    
}

