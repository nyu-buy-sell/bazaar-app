//
//  PostViewController.swift
//  Bazaar
//
//  Created by Rita Han on 12/2/21.
//

import UIKit
import AlamofireImage
import Parse
class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    


    //@IBOutlet weak var academicMenu: UIMenu!
    var selectedCategory : String = "";
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var itemNameField: UITextField!
    
    @IBOutlet weak var descriptionField: UITextField!
    
    @IBOutlet weak var pickupInfoField: UITextField!
    
    @IBOutlet weak var contactInfoField: UITextField!
    

    @IBOutlet weak var categorySegmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }
    
    @IBAction func imageButon(_ sender: Any) {
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
    //to display the image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageScaled(to: size)
        
        imageView.image = scaledImage
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func categoryChanged(_ sender: Any) {
        switch categorySegmentControl.selectedSegmentIndex {
    case 0:
        selectedCategory = "Furniture"
    case 1:
        selectedCategory = "Academic"
    default:
        break
        }
    }
    
    
    @IBAction func postButton(_ sender: Any) {
        let post = PFObject(className: "Posts")
        
        post["itemName"] = itemNameField.text!
        post["description"] = descriptionField.text!
        post["pickUpInfo"] = pickupInfoField.text!
        post["contactInfo"] = contactInfoField.text!
        post["author"] = PFUser.current()!
        post["category"] = selectedCategory
        
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(data: imageData!)
        post["image"] = file
        
        post.saveInBackground{(success, error) in
            if success{
                self.dismiss(animated: true, completion: nil)
                print("saved")
            }else{
                print("error")
            }
        }

    }
    
    @IBAction func cancelButton(_ sender: Any) {
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
