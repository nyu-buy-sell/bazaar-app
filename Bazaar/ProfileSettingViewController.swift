//
//  ProfileSettingViewController.swift
//  Bazaar
//
//  Created by Rita Han on 12/8/21.
//

import UIKit
import Parse

class ProfileSettingViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    
    let user = PFUser.current()

    override func viewDidLoad() {
        //super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        userName.text = user!["username"] as? String
        if(user!["location"] != nil){
            location.text = user!["location"] as? String
        }
        if(user!["email"] != nil){
            email.text = user!["email"] as? String
        }
        if(user!["phoneNumber"] != nil){
            phoneNumber.text = user!["phoneNumber"] as? String
        }
        if(user!["profilePic"] != nil){
            let imageFile = user!["profilePic"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            
            profileImageView.af_setImage(withURL: url)
        }
        

        super.viewDidLoad()
    }
    
    @IBAction func onCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSaveButton(_ sender: Any) {
        user!["username"] = userName.text!
        user!["email"] = email.text!
        user!["phoneNumber"] = phoneNumber.text!
        user!["location"] = location.text!
        
        let imageData = profileImageView.image!.pngData()
        let file = PFFileObject(data: imageData!)
        user!["profilePic"] = file
        
        user!.saveInBackground{(success, error) in
            if success{
                self.dismiss(animated: true, completion: nil)
                print("profile saved")
            }else{
                print("error saving profile")
            }
        }
    }
    
    @IBAction func onProfileCameraButton(_ sender: Any) {
        print("tapped")
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        }else{
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageScaled(to: size)
        
        profileImageView.image = scaledImage
        dismiss(animated: true, completion: nil)
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
