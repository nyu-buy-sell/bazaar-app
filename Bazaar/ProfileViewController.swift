//
//  ProfileViewController.swift
//  Bazaar
//
//  Created by Rita Han on 12/8/21.
//

import UIKit
import Parse
import AlamofireImage

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var location: UILabel!
    let user = PFUser.current()

    override func viewDidLoad() {
        super.viewDidLoad()
        userName.text = user!["username"] as? String
        if(user!["location"] != nil){
            location.text = user!["location"] as? String
        }
        if(user!["profilePic"] != nil){
            let imageFile = user!["profilePic"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            profilePicImageView.af_setImage(withURL: url)
        }
        // Do any additional setup after loading the view.
        
        viewWillAppear(true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        userName.text = user!["username"] as? String
        if(user!["location"] != nil){
            location.text = user!["location"] as? String
        }
        if(user!["profilePic"] != nil){
            let imageFile = user!["profilePic"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            profilePicImageView.af_setImage(withURL: url)
        }
    }

    
    @IBAction func onLogoutButton(_ sender: Any) {
        
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")//instance of login view controllwe
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else {return}//create delegate
        
        delegate.window?.rootViewController = loginViewController
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
