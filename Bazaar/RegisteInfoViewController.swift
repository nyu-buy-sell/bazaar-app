//
//  RegisteInfoViewController.swift
//  Bazaar
//
//  Created by Rita Han on 12/9/21.
//

import UIKit
import Parse
class RegisteInfoViewController: UIViewController {
    
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var location: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onclickNextButton(_ sender: Any) {
        let user = PFUser.current()
        
        user!["email"] = email.text!
        user!["phoneNumber"] = phoneNumber.text!
        user!["location"] = location.text!
        
        user!.saveInBackground{(success, error) in
            if success{
//                self.dismiss(animated: true, completion: nil)
                print("registration info saved")
            }else{
                print("error saving registration info")
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
