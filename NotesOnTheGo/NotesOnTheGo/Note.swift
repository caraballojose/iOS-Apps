//
//  Note.swift
//  NotesOnTheGo
//
//  Created by Jose Caraballo on 26/3/21.
//
import Foundation
import RealmSwift

class Note: Object {
    
    @objc var checked : Bool = false
    @objc var title : String = ""
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "notes")
    
}
