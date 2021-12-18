//
//  UserPostViewController.swift
//  Bazaar
//
//  Created by Rita Han on 12/17/21.
//

import UIKit
import Parse
import AlamofireImage

class UserPostViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    var posts = [PFObject]()
    let query = PFQuery(className: "Posts")//create a query
    var user = PFObject.init(className: "User")

    override func viewDidLoad() {
        print("user posts")
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        query.includeKeys(["author"])//include author info, or else will crush b/c it's pointer not the actual content
        query.limit = 20
        query.order(byDescending: "updatedAt")
        query.whereKey("author", equalTo: user)

        query.findObjectsInBackground {(posts, error) in
            if posts != nil{//if there is query
                //print(posts)
                self.posts = posts!//put in the variable
                self.tableView.reloadData()//and reload
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            print("cell begin")

            let cell = tableView.dequeueReusableCell(withIdentifier: "UsersPostCell") as! UsersPostCell
            let post = posts[indexPath.row]
    
            cell.itemNameLabel.text = post["itemName"] as? String
            cell.desciptionLabel.text = post["description"] as? String
    
            let imageFile = post["image"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            print(url)
            cell.postPhoroView.af_setImage(withURL: url)
            print("cell end")
            print(cell)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
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
