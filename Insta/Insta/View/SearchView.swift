//
//  SearchView.swift
//  Insta
//
//  Created by Jose Caraballo on 22/3/21.
//

import UIKit

class SearchView: UIView {
    
    private let titleLabel : UILabel = {
        
        let label = UILabel()
        label.text = "Please Fill out the following form"
        label.textColor = .cyan
        label.font.withSize(20)
        return label
        
    }()
    
     var textFieldName : UITextField = {
        
        let text = UITextField()
        text.placeholder = " Testing TextField"
        text.tintColor = .blue
        text.backgroundColor = .white
        text.alpha = 0.3
        return text
        
    }()
    
    
    var labelName : UILabel = {
       
       let text = UILabel()
        text.text = "Nombre"
       text.tintColor = .blue
       return text
       
   }()
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, width: 250, height: 25)
        titleLabel.centerX(inView: self)
        
        stackView()
        /*
        addSubview(labelName)
        labelName.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, paddingTop: 5.0, paddingLeft: 16)
        
        addSubview(textFieldName)
        textFieldName.anchor(top: titleLabel.topAnchor, left: labelName.leftAnchor, paddingTop: 5.0, paddingLeft: 16)
         */
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func stackView() {
        
        let stack = UIStackView(arrangedSubviews: [labelName, textFieldName])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        
        addSubview(stack)
        stack.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 20.0, paddingLeft: 20.0, paddingRight: 20.0)
        
    }
    
}
