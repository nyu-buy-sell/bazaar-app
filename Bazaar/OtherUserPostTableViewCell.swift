//
//  OtherUserPostTableViewCell.swift
//  Bazaar
//
//  Created by Rita Han on 12/17/21.
//

import UIKit

class OtherUserPostTableViewCell: UITableViewCell {

    
    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
