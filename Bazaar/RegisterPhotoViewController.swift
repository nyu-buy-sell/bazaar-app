//
//  RegisterPhotoViewController.swift
//  Bazaar
//
//  Created by Rita Han on 12/9/21.
//

import UIKit
import Parse

class RegisterPhotoViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var profileImageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onclickProfilePicButton(_ sender: Any) {
        print("clicked profile")
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
    
    
    @IBAction func onclickFinishButton(_ sender: Any) {
        print("clicked finish")

        let user = PFUser.current()

        let imageData = profileImageView.image!.pngData()
        let file = PFFileObject(data: imageData!)
        user!["profilePic"] = file
        
        user!.saveInBackground{(success, error) in
            if success{
                //self.dismiss(animated: true, completion: nil)
                print("profile pic saved")
            }else{
                print("error saving profile pic")
            }
        }
                
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
