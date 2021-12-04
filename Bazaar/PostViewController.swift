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
    
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var academicButton: UIButton!
    @IBOutlet weak var furnitureButton: UIButton!
    @IBOutlet weak var category1Button: UIButton!
    @IBOutlet weak var category2Button: UIButton!
    @IBOutlet weak var category3Button: UIButton!
    
    var generalCategory: [UIButton] = []
    var specificCategory: [UIButton] = []
//    let categories: [UIButton] = [academicButton, furnitureButton, category1Button, category2Button, category3Button ]
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var itemNameField: UITextField!
    
    @IBOutlet weak var descriptionField: UITextField!
    
    @IBOutlet weak var pickupInfoField: UITextField!
    
    @IBOutlet weak var contactInfoField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        generalCategory = [academicButton, furnitureButton]
        specificCategory = [category1Button, category2Button, category3Button]
        
        for category in generalCategory {
            category.isSelected = false
        }
        for category in specificCategory {
            category.isSelected = false
        }
        academicButton.setTitle("Academic", for: .normal)
        furnitureButton.setTitle("Furniture", for: .normal)


        
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onclickAcademicButton(_ sender: Any) {
        furnitureButton.backgroundColor = .white
        category1Button.setTitle("textbook", for: .normal)
        category2Button.isHidden = true
        category3Button.setTitle("course notes", for: .normal)
        furnitureButton.isSelected = false
        academicButton.backgroundColor = .lightGray
        academicButton.isSelected = true

    }
    
    @IBAction func onclickFurnitureButton(_ sender: Any) {
        academicButton.backgroundColor = .white
        category1Button.setTitle("bedroom", for: .normal)
        category2Button.isHidden = false
        category2Button.setTitle("kitchen", for: .normal)
        category3Button.setTitle("living room", for: .normal)
        academicButton.isSelected = false
        furnitureButton.backgroundColor = .lightGray
        furnitureButton.isSelected = true

    }
    
    @IBAction func onclickCategory1Button(_ sender: Any) {
        category1Button.backgroundColor = .lightGray
        category1Button.isSelected = true

        category2Button.isSelected = false
        category2Button.backgroundColor = .white
        category3Button.isSelected = false
        category3Button.backgroundColor = .white


    }
    
    @IBAction func onclickCategory2Button(_ sender: Any) {
        category2Button.backgroundColor = .lightGray
        category2Button.isSelected = true

        category1Button.isSelected = false
        category1Button.backgroundColor = .white
        category3Button.isSelected = false
        category3Button.backgroundColor = .white


    }
    
    @IBAction func onclickCategory3Button(_ sender: Any) {
        category3Button.backgroundColor = .lightGray
        category3Button.isSelected = true

        category1Button.isSelected = false
        category1Button.backgroundColor = .white
        category2Button.isSelected = false
        category2Button.backgroundColor = .white


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
    


    
    @IBAction func postButton(_ sender: Any) {
        let post = PFObject(className: "Posts")
        
        post["itemName"] = itemNameField.text!
        post["description"] = descriptionField.text!
        post["pickUpInfo"] = pickupInfoField.text!
        post["contactInfo"] = contactInfoField.text!
        post["author"] = PFUser.current()!
        
        
        for category in generalCategory {
            print(category.isSelected)
            if category.isSelected == true{
                print(category.title(for:.normal))
                post["generalCategory"] = category.title(for:.normal)
            }
        }
        for category in specificCategory {
            if category.isSelected == true{
                print("speCat true")
                post["specificCategory"] = category.title(for:.normal)
            }
        }
        
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
