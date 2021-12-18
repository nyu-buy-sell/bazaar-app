//
//  OtherUserPostViewController.swift
//  Bazaar
//
//  Created by Rita Han on 12/17/21.
//

import UIKit
import Parse
import AlamofireImage

class OtherUserPostViewController: UINavigationController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var posts = [PFObject]()
    let query = PFQuery(className: "Posts")//create a query
    
    var user = PFObject.init(className: "User")

//    @IBOutlet weak var descriptionLabel: UILabel!
//    @IBOutlet weak var itemNameLabel: UILabel!
//    @IBOutlet weak var postImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("other user post")
        print(user)
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        print("view did appear")
        
        query.includeKeys(["author"])//include author info, or else will crush b/c it's pointer not the actual content
        query.limit = 20
        query.order(byDescending: "updatedAt")
        query.whereKey("author", equalTo: user)

        query.findObjectsInBackground {(posts, error) in
            if posts != nil{//if there is query
                self.posts = posts!//put in the variable
                self.tableView.reloadData()//and reload
            }
        }
    }

    @IBAction func onclickBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        print("table view cell")

        let cell = tableView.dequeueReusableCell(withIdentifier: "OtherUserPostTableViewCell") as! OtherUserPostTableViewCell
//
//        let post = posts[indexPath.row]
//
//        cell.itemNameLabel.text = post["itemName"] as? String
//        cell.descriptionLabel.text = post["description"] as? String
//
//        let imageFile = post["image"] as! PFFileObject
//        let urlString = imageFile.url!
//        let url = URL(string: urlString)!
//        print(url)
//        cell.postImageView.af_setImage(withURL: url)

        return cell


    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
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
