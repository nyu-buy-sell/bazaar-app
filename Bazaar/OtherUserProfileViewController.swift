//
//  OtherUserProfileViewController.swift
//  Bazaar
//
//  Created by Rita Han on 12/17/21.
//

import UIKit
import Parse
import AlamofireImage

class OtherUserProfileViewController: UIViewController {
    
    var user = PFObject.init(className: "User")
    
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("profile page")
        print(user)
        print(user["username"])
        
        userNameLabel.text = user["username"] as? String
        
        if(user["phoneNumber"] != nil){
            phoneLabel.text = user["phoneNumber"] as? String
        }
        if(user["email"] != nil){
            emailLabel.text = user["email"] as? String
        }
        if(user["location"] != nil){
            locationLabel.text = user["location"] as? String
        }
        
        
        if(user["profilePic"] != nil){
            let imageFile = user["profilePic"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            profilePicImageView.af_setImage(withURL: url)
        }
        // Do any additional setup after loading the view.
        
        viewWillAppear(true)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onclickSeePostButton(_ sender: Any) {
    }
    
    override func prepare (for segue: UIStoryboardSegue, sender: Any?){
        print("clicked")
        if(segue.identifier == "userProfilePostSegue"){
            let nav = segue.destination as! UINavigationController
            let profilePostViewController = nav.viewControllers.first as! UserPostViewController
            profilePostViewController.user = user
            
        }
//        let detailViewController = segue.destination as! OtherUserProfileViewController
//        detailViewController.user = user
//        let detailViewController = segue.destination as! OtherUserProfileViewController
        //detailViewController.user = user

    }
    
    
    @IBAction func onclickBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
