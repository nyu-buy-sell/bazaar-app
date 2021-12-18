//
//  HomePostViewController.swift
//  Bazaar
//
//  Created by Rita Han on 12/17/21.
//

import UIKit
import Parse
import AlamofireImage


class HomePostViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var specificCatLabel: UILabel!
    @IBOutlet weak var genCatLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pickupInfoLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    
    var post = PFObject.init(className: "Posts")
    var user = PFObject.init(className: "User")

    override func viewDidLoad() {
        super.viewDidLoad()
        print(post)
        if(post["itemName"] != nil){
            itemNameLabel.text = post["itemName"] as! String
        }
        if(post["specificCategory"] != nil){
            specificCatLabel.text = post["specificCategory"]as! String
        }
        if(post["generalCategory"] != nil){
            genCatLabel.text = post["generalCategory"] as! String
        }
        if(post["description"] != nil){
            descriptionLabel.text = post["description"] as! String
        }
        if(post["pickUpInfo"] != nil){
            pickupInfoLabel.text = post["pickUpInfo"] as! String
        }
        if(post["contactInfo"] != nil){
            contactLabel.text = post["contactInfo"] as! String
        }
        
        user = post["author"] as! PFObject
        //let author = post["author"] as! PFObject
        userNameLabel.text = user["username"] as! String
        // Do any additional setup after loading the view.
        
        if(user["profilePic"] != nil){
            let imageFile = user["profilePic"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            profileImageView.af_setImage(withURL: url)
        }
        
        if(post["image"] != nil){
            let imageFile = post["image"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            postImageView.af_setImage(withURL: url)
        }
        // Do any additional setup after loading the view.
        viewWillAppear(true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
//    @IBAction func onclickProfileButton(for segue: UIStoryboardSegue, sender: Any?) {
//        print("clicked")
//        let detailViewController = segue.destination as! HomePostViewController
//        detailViewController.user = user
//        print(user)
//        print(user["username"])
//
////
//    }
    override func prepare (for segue: UIStoryboardSegue, sender: Any?){
        print("clicked")
        if(segue.identifier == "userProfileSegue"){
            let nav = segue.destination as! UINavigationController
            let profileViewController = nav.viewControllers.first as! OtherUserProfileViewController
            profileViewController.user = user
            
        }
        print(user)
        print(user["username"])
    }
    
}
