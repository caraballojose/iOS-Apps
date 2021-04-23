//
//  MessageCell.swift
//  ChatApp
//
//  Created by Jose Caraballo on 14/4/21.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var messageImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.messageBackground.layer.cornerRadius = 10.0
    }
    @IBOutlet weak var messageBackground: UIView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
