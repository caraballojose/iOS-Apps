//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Jose Caraballo on 8/4/21.
//

import UIKit
import Firebase
import ProgressHUD

class ChatViewController: UIViewController {
    
    let boxChat : UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        return v
    }()
    
    let tableMsg : UITableView = {
        let tv = UITableView()
        return tv
    }()
    
    let viewBottom : UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
        return v
    }()
    
    
    let textFieldChat: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Escriba aquí"
        tf.setHeight(40)
        tf.borderStyle = .roundedRect
        tf.autoresizesSubviews = false
        return tf
    }()
    
    let sendButton: UIButton = {
        let bt = UIButton()
        bt.setTitle("Enviar", for: .normal)
        bt.setTitleColor(#colorLiteral(red: 0.9117072225, green: 0.9117072225, blue: 0.9117072225, alpha: 1), for: .normal)
        bt.setHeight(40)
        bt.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        bt.setDimensions(height: 30, width: 70)
        return bt
    }()
    
    var textboxHeight : CGFloat = 80
    
    var messagesArray : [Message] = []
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableMsg.delegate = self
        self.textFieldChat.delegate = self
        self.tableMsg.dataSource =  self
        
        self.tableMsg.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "MessageCell")
        self.tableMsg.separatorStyle = .none
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(messageTableViewTapped))
        self.tableMsg.addGestureRecognizer(tapGesture)
        
        configureTableView()
        configureView()
        retrieveMessageFromFirebase()
    }
    // Tama;a correcto de las celdas de la tabla
    func configureTableView() {
        self.tableMsg.rowHeight = UITableView.automaticDimension
        self.tableMsg.estimatedRowHeight = 120
    }
    
    func configureView() {

        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOut))
        navigationItem.setHidesBackButton(true, animated: true)
        boxChat.addSubview(tableMsg)
        tableMsg.anchor(top: boxChat.topAnchor, left: boxChat.leftAnchor, bottom: boxChat.bottomAnchor, right: boxChat.rightAnchor)
        view.addSubview(boxChat)
        boxChat.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 80)
        
        let stack =  UIStackView(arrangedSubviews: [textFieldChat,sendButton])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .center
        stack.spacing = 6
        
        viewBottom.addSubview(stack)
        stack.anchor(top: viewBottom.topAnchor, left: viewBottom.leftAnchor, right: viewBottom.rightAnchor, paddingTop: 6, paddingLeft: 6, paddingRight: 6)
        view.addSubview(viewBottom)
        viewBottom.anchor(top: boxChat.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    //MARK: - Firebase
    
    func retrieveMessageFromFirebase() {
        
        let messageDB = Database.database().reference().child("Messages")
        messageDB.observe(.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            let sender = snapshotValue["sender"]!
            let body = snapshotValue["body"]!
            
            let msg = Message(sender: sender, body: body)
            self.messagesArray.append(msg)
            self.configureTableView()
            self.tableMsg.reloadData()
        }
        
    }
    
    //MARK: -  Actions
    
    @objc func logOut() {
        
        do {
            try Auth.auth().signOut()
        }catch{
            print("Error: no se pudo hacer el log out")
        }
        
        guard navigationController?.popToRootViewController(animated: true) != nil else {
            print("No hay VC que eliminar del stack")
            return
        }
        
    }
    
    @objc func messageTableViewTapped() {
        self.textFieldChat.endEditing(true)
        UIView.animate(withDuration: 0.5) {
            self.boxChat.anchor(paddingBottom: 80)
            print("Fin de la escritura")
        }
        
    }
    
    @objc func sendMessage() {
        textFieldChat.endEditing(true)
        
        textFieldChat.isEnabled = false
        sendButton.isEnabled = false
        
        let msgDB = Database.database().reference().child("Messages")
        let messageDict = ["sender": Auth.auth().currentUser?.email,
                           "body": self.textFieldChat.text!]
        
        msgDB.childByAutoId().setValue(messageDict) { (error, ref) in
            if error != nil {
                print(error!)
            } else {
                print("Mensaje guardado exitosamente")
                self.textFieldChat.isEnabled = true
                self.sendButton.isEnabled = true
                self.textFieldChat.text = ""
            }
        }
    }
    
}

extension ChatViewController : UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messagesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        
        cell.usernameLabel.text = messagesArray[indexPath.row].sender
        cell.messageLabel.text = messagesArray[indexPath.row].body
        cell.messageImageView.image = #imageLiteral(resourceName: "wargreymon")
        
        if cell.usernameLabel.text == Auth.auth().currentUser?.email {
            cell.messageImageView.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            cell.messageBackground.backgroundColor = #colorLiteral(red: 0.4464960516, green: 0.7004465783, blue: 1, alpha: 1)
        } else {
            cell.messageImageView.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
            cell.messageBackground.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
        
        return cell
    }
    
    
}

extension ChatViewController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.boxChat.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, left: self.view.leftAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, right: self.view.rightAnchor, paddingBottom: 80 + 30 + 258)
            print("Comenzo la edicion del TextField")
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.messageTableViewTapped()
        print("dejo de escribir")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
