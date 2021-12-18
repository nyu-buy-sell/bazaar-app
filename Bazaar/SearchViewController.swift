//
//  SearchViewController.swift
//  Bazaar
//
//  Created by Bhavig Pointi on 12/10/21.
//

import UIKit
import AlamofireImage
import Parse

class SearchViewController: UIViewController, UISearchBarDelegate{
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print( "searchText: \(searchText)")
        
    }
    
    @IBAction func onSearchClick(_ sender: Any) {
        let query = PFQuery(className: "Posts")
        query.whereKey("itemName", matchesText: searchBar.text!)
        query.findObjectsInBackground{(objects: [PFObject]?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else if let objects = objects{
                objects.forEach { (object) in
                    print("successfully retrieved \(String(describing: object))");
                }
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
    
