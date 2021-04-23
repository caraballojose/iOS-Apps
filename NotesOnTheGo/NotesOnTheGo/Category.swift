//
//  Category.swift
//  NotesOnTheGo
//
//  Created by Jose Caraballo on 13/3/21.
//
import UIKit
import Foundation
import RealmSwift

class Category: Object {
    
    @objc var colorHex : String?
    @objc var image : Data?
    @objc var title : String?
    
    let notes = List<Note>()
    
}

extension Category {
    
    var color : UIColor? {
        get {
            guard let hex = colorHex else { return nil }
            return UIColor(hex: hex)
        }
        
        set (newColor){
            if let newColor = newColor {
                colorHex = newColor.toHex
            }
        }
    }
    
}
