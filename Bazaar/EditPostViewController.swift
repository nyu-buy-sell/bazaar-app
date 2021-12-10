//
//  EditPostViewController.swift
//  Bazaar
//
//  Created by Rita Han on 12/10/21.
//

import UIKit
import Parse
class EditPostViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var pickUpInfo: UITextField!
    @IBOutlet weak var photoView: UIImageView!
    
    var posts = [PFObject]()
    let query = PFQuery(className: "Posts")//create a query
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func onclickCameraButton(_ sender: Any) {
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
        
        photoView.image = scaledImage
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onclickSaveButton(_ sender: Any) {
    }
    
    @IBAction func onclickCancelButton(_ sender: Any) {
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
