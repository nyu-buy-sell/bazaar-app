//
//  UsersPostCell.swift
//  Bazaar
//
//  Created by Rita Han on 12/17/21.
//

import UIKit

class UsersPostCell: UITableViewCell {

    @IBOutlet weak var desciptionLabel: UILabel!
    @IBOutlet weak var postPhoroView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
