//
//  Song.swift
//  WebScrapping
//
//  Created by Jose Caraballo on 11/2/21.
//

import Foundation

class Song {
    
    var title : String
    var postURL : String
    var imageURL : String
    var uuid : String
    var imageDownloaded : Bool
    
    init(title: String, postUrl: String ) {
        
        self.uuid = UUID().uuidString
        self.imageDownloaded = false
        self.title = title
        self.postURL = postUrl
        self.imageURL = "http://juangabrielgomila.com/wp-content/uploads/2015/09/ic_launcher@3x.png"
        
    }
    
    init(title: String, postUrl: String, imageUrl: String) {
        
        self.uuid = UUID().uuidString
        self.imageDownloaded = false
        self.title = title
        self.postURL = postUrl
        self.imageURL = imageUrl
        
    }
    
}
