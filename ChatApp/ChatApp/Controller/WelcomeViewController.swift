//
//  ViewController.swift
//  ChatApp
//
//  Created by Jose Caraballo on 5/4/21.
//

import UIKit
import Firebase

class WelcomeViewController: UIViewController {
  
    let backG : UIImageView = {
        
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.alpha = 0.8
        iv.image = #imageLiteral(resourceName: "tren")
        
        return iv
    }()

    let signButtom : UIButton = {
        let bt = UIButton()
        bt.setTitle("Sign In", for: .normal)
        bt.backgroundColor = #colorLiteral(red: 0.7617198051, green: 0.5408549882, blue: 0.4521143913, alpha: 1)
        bt.setTitleColor(.white, for: .normal)
        bt.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        return bt
    }()
    
    let logInButton : UIButton = {
        let bt = UIButton()
        bt.setTitle("Log In", for: .normal)
        bt.backgroundColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
        bt.setTitleColor(.white, for: .normal)
        bt.titleShadowColor(for: .normal)
        bt.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        
        return bt
    }()
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureUI()
        //view.addBackground(image: #imageLiteral(resourceName: "puente"))
        if Auth.auth().currentUser != nil {
            self.navigationController?.pushViewController(ChatViewController(), animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureUI() {
        
        //navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Welcome"
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.font : UIFont(name: "Avenir Next", size: 30) ?? UIFont.boldSystemFont(ofSize: 30)
        ]
        
        view.addSubview(backG)
        backG.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)

        let stack = UIStackView(arrangedSubviews: [logInButton,signButtom])
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 4
        signButtom.setDimensions(height: 50, width: view.frame.width)
        logInButton.setDimensions(height: 50, width: view.frame.width)
        
        view.addSubview(stack)
        stack.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 50)
    }
    
//MARK:- Actions
    
    @objc func logIn(){
        let loginVC = LoginViewController()
        navigationController?.pushViewController(loginVC, animated: true)
    }
    @objc func signIn(){
        let signVC = RegisterViewController()
        navigationController?.pushViewController(signVC, animated: true)
    }



}

