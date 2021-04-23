//
//  FeedController.swift
//  Insta
//
//  Created by Jose Caraballo on 18/3/21.
//

import UIKit

class FeedController: UICollectionViewController {
    
    private let reuseIndentifier = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        collectionView.backgroundColor = .white
        
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: reuseIndentifier)
    }
    
}

extension FeedController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIndentifier, for: indexPath) as! FeedCell
    
        return cell
    }
    
}

extension FeedController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        var height  = width + 8 + 40 + 8
        height += 50
        height += 60
        
        return CGSize(width: view.frame.width, height: height)
    }
    
}
