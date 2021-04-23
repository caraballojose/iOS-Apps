//
//  Category.swift
//  NotesOnTheGo
//
//  Created by Jose Caraballo on 13/3/21.
//
import UIKit
import Foundation

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
