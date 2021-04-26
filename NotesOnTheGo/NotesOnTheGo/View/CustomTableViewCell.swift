//
//  CustomTableViewCell.swift
//  NotesOnTheGo
//
//  Created by Jose Caraballo on 6/3/21.
//

import UIKit

protocol CellDelagate: AnyObject {
    func deleteCell(id: Int)
}

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var titleCell: UILabel!
    
    var id : Int? = nil
    var delegate: CellDelagate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func deleteButtom(_ sender: UIButton) {
        guard let id = id else {return}
        delegate?.deleteCell(id: id)
    }
}
