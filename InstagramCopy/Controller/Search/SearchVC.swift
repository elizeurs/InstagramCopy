//
//  SearchVC.swift
//  InstagramCopy
//
//  Created by Elizeu RS on 20/04/19.
//  Copyright © 2019 elizeurs. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "SearchUserCell"

class SearchVC: UITableViewController {
  
  //  MARK: - Properties
  
  var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
      
//      register cell classes
      tableView.register(SearchUserCell.self, forCellReuseIdentifier: reuseIdentifier)
      
//      separator insets
      tableView.separatorInset = UIEdgeInsets(top: 0, left: 64, bottom: 0, right: 0)
      
//      configure nav controller
      configureNavController()
      
//      fetch users
      fetchUsers()
      

    }

    // MARK: - Table view data source
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let user = users[indexPath.row]
    
//    create instance of user profile vc
    let userProfileVC = UserProfileVC(collectionViewLayout: UICollectionViewFlowLayout())
    
//    passes user from searchvc to userProfilevc
    userProfileVC.user = user
    
//    push view controller
    navigationController?.pushViewController(userProfileVC, animated: true)
    
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SearchUserCell
    
    cell.user = users[indexPath.row]
    
    return cell
  }

  //  MARK: - Handlers
  
  func configureNavController() {
    navigationItem.title = "Explore"
  }
  
  //  MARK: - API
  
  func fetchUsers() {
    
    Database.database().reference().child("users").observe(.childAdded) { (snapshot) in
      
//      uid
      let uid = snapshot.key
      
      Database.fetchUser(with: uid, completion: { (user) in
        self.users.append(user)
        
        self.tableView.reloadData()
      })
    }
  }
}
