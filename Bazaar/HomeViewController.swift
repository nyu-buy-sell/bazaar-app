//
//  HomeViewController.swift
//  Bazaar
//
//  Created by Rita Han on 12/2/21.
//  Edited by Sashank Silwal on 12/09/21.
//

import UIKit
import Parse
import AlamofireImage

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 350

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Posts")
        query.includeKey("author")
        query.limit = 50
        query.order(byDescending: "updatedAt")
        query.findObjectsInBackground{(posts, error) in
            if posts != nil{
                self.posts = posts!
                self.tableView.reloadData()
                
                
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomePostCell") as! HomePostCell
        let post = posts[indexPath.row]
        
        let user = post["author"] as! PFUser
        cell.userNameLabel.text = user.username
        
        cell.itemNameLabel.text = post["itemName"] as! String
 
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        cell.itemPhotoView.af_setImage(withURL: url)
        
//        let currentUser = PFUser.current()
        if(user["profilePic"] != nil){
            let imageFile = user["profilePic"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            cell.userPhotoView.af_setImage(withURL: url)
        }
        
        
//        print(posts)
        return cell
        
    }
    
    
    //preparation stage before navigation
    override func prepare (for segue: UIStoryboardSegue, sender: Any?){
        //get the new view controller using segue.destination
        //pass the selected object to the new view controller
        print("Laoding up the details scree")

        //find selected post
        let cell = sender as! UITableViewCell //casting
        let indexPath = tableView.indexPath(for:cell)! //ask tableView for the index of teh cell
        print(indexPath.row)
        let post = posts[indexPath.row] //find the post using the index
        print(post)
//        let point = sender.convert(CGPoint.zero, to: tableView)
//        guard let indexpath = tableView.indexPathForRow(at: point)
//        else{return}

//        //pass selected movie to the details view controller
        let detailViewController = segue.destination as! HomePostViewController
        detailViewController.post = post
//
        tableView.deselectRow(at: indexPath, animated: true)
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
