//
//  IndividualItemDetailsViewController.swift
//  Bazaar
//
//  Created by Sashank Silwal on 12/16/21.
//

import UIKit
import Parse
import AlamofireImage

class IndividualItemDetailsViewController: UIViewController {
    var post:  PFObject!
 
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var contactInfoLabel: UILabel!
    @IBOutlet weak var pickupInfoLabel: UILabel!
    
    @IBOutlet weak var userProfileImage: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var generalCategoryLabel: UILabel!
    
    @IBOutlet weak var specificCategoryLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting the user info
        let user = post["author"] as! PFUser
        userNameLabel.text = user.username
        
        // setting the user profile picture
        if(user["profilePic"] != nil){
            let imageFile = user["profilePic"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            userProfileImage.af_setImage(withURL: url)
        }
        
        // setting the item picture
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        postImage.af_setImage(withURL: url)
        
        // setting the item into
        itemNameLabel.text = post["itemName"] as? String
        descriptionLabel.text = post["description"] as? String
        contactInfoLabel.text = post["contactInfo"] as? String
        pickupInfoLabel.text = post["pickUpInfo"] as? String
        generalCategoryLabel.text = post["generalCategory"] as? String
        specificCategoryLabel.text = post["specificCategory"] as? String
        
       
        
       
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
