//
//  HomePostCell.swift
//  Bazaar
//
//  Created by Sashank Silwal on 12/9/21.
//

import UIKit

class HomePostCell: UITableViewCell {

    @IBOutlet weak var itemPhotoView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var itemNameLabel: UILabel!
    
    @IBOutlet weak var userPhotoView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
