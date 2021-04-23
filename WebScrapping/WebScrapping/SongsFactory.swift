//
//  SongsFactory.swift
//  WebScrapping
//
//  Created by Jose Caraballo on 11/2/21.
//

import Foundation
import Alamofire
import Kanna

class SongsFactory  {
    
    var songs = [Song]()
    
    var songUrl : String
    
    var completedSong = 0
    
    init(songsUrl: String) {
        
        self.songUrl = songsUrl
        scrappeURL()
        
        for song in 0..<songs.count {
            print(songs[song].title + songs[song].imageURL)
        }
        
    }
    
    func scrappeURL() {
        
        AF.request(songUrl).responseString { response in
           
            do {
                if let htmlString = try? response.result.get(){
                    self.parseHtml(html: htmlString)
                    
                }
                
            } catch {
                print(Error.self)
            }
        }
    }
    
    func parseHtml(html: String){
       //print(html)
        
        do {
            let doc = try Kanna.HTML(html: html, encoding: String.Encoding.utf8)
            
            for article in doc.css("article"){
               
                for header in article.css("header"){
                    
                    for a in header.css("a")
                    {
                        let title : String = a.text!
                        if title != ""
                        {
                            let song = Song(title: title, postUrl : a["href"]!)
                            self.songs.append(song)
                            self.getImageForUrl(titulo: title, forSong: a["href"]!)
                        
                            NotificationCenter.default.post(name: NSNotification.Name("SongsUpdated"), object: nil)
                            
                        }
                        break
                    }
                     
                }
               
            }// fin article
          
        } catch {
            print(Error.self)
        }
        
    }
    
    func getImageForUrl(titulo: String, forSong id: String) {
        
        AF.request(songUrl).responseString { response in
           
            do {
                if let htmlString = try? response.result.get(){
                    self.parseImage(htmlString: htmlString, forSong: id, tittle: titulo)
                    
                }
                
            } catch {
                print(Error.self)
            }
        }
        
    }
    
    func parseImage(htmlString : String, forSong post: String, tittle: String) {
        do {
            
            let doc = try Kanna.HTML(html: htmlString, encoding: String.Encoding.utf8)
            //print(doc)
            
            
            for a in doc.css("a"){
                
                if a["class"] == "entry-thumb"{
                
                    for img in a.css("img") {
                        
                        for song in songs {
                            if a["href"] == post {
                                song.imageURL = img["src"]!
                                //song.postURL = post
                                //song.title = tittle
                                completedSong += 1
                                NotificationCenter.default.post(name: NSNotification.Name("SongsUpdated"), object: nil)
                                print("Estado de completacion: \(song.title) \(completedSong) / \(songs.count) | \(song.imageURL) | \(song.postURL)")
                                break
                            }
                            
                        }
                        
                    
                    }
                    
                }
                    
                }
        
        
        
        }catch {
            print(error)
        }
    }
    
    
    
    
}
