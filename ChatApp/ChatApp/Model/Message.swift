//
//  Message.swift
//  ChatApp
//
//  Created by Jose Caraballo on 14/4/21.
//

import Foundation

class Message {
    var sender : String = ""
    var body : String = ""
    
    init(sender: String, body: String){
        self.sender = sender
        self.body = body
    }
    
    init(){
        sender = "Jose Caraballo"
        body = "Mensaje de prueba para aplicacion de Chat en iOS"
    }
}
