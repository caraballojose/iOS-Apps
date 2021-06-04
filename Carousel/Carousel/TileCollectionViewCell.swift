//
//  TileCollectionViewCell.swift
//  Carousel
//
//  Created by Jose Caraballo on 7/5/21.
//

import UIKit

struct TileCollectionTableViewCellViewModel {
    let name: String
    let backgroundColor : UIColor
}

class TileCollectionTableViewCell: UICollectionViewCell {
    
    static let identifier = "TileCollectionTableViewCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        contentView.layer.cornerRadius = 6
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.quaternaryLabel.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //label.frame = contentView.bounds
        label.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: TileCollectionTableViewCellViewModel) {
        contentView.backgroundColor = viewModel.backgroundColor
        label.text = viewModel.name
    }
    
    
}
