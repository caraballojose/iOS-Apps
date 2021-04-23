	//
//  ViewController.swift
//  WebScrapping
//
//  Created by Jose Caraballo on 6/2/21.
//

import UIKit
import Alamofire
import Kanna
    

class ViewController: UICollectionViewController {
    
    @IBOutlet weak var ViewImage: UIImageView!
    
    var imgArray : [String] = []
    let urlname = "http://juangabrielgomila.com/portfolio/"
    var factory : SongsFactory!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector (self.reloadedItemInCollectionView), name: NSNotification.Name("SongsUpdated"), object: nil)
         
        self.factory = SongsFactory(songsUrl: urlname)
        
        
    
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return factory.songs.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SongCell", for: indexPath) as! SongCell
        
        cell.labelSong.text = factory.songs[indexPath.row].title
        cell.imageViewSong.downloadedFrom(link: factory.songs[indexPath.row].imageURL)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let url = URL(string: factory.songs[indexPath.row].postURL){
            UIApplication.shared.open(url, options: [:]) { (success) in
                
                print("Hemos ido al sitio... \(self.factory.songs[indexPath.row])")
                
            }
        }
    }
    
    @objc func reloadedItemInCollectionView (){
        self.collectionView.reloadData()
    }
    

}

