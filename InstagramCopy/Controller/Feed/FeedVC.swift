//
//  FeedVC.swift
//  InstagramCopy
//
//  Created by Elizeu RS on 20/04/19.
//  Copyright © 2019 elizeurs. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class FeedVC: UICollectionViewController, UICollectionViewDelegateFlowLayout, FeedCellDelegate {
  
  
  //  MARK: - Properties
  
  var posts = [Post]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView?.backgroundColor = .white
    
    // register cell classes
    self.collectionView!.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    
    //      configure  logout button
    configureNavigationBar()
    
//    fetch posts
    fetchPosts()
    
  }
  
  //  MARK: - UICollectionViewFlowLayout
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let width = view.frame.width
    var height = width + 8 + 40 + 8
    height += 50
    height += 60
    
    return CGSize(width: width, height: height)
    
  }
  
  // MARK: UICollectionViewDataSource
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return posts.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell
    
    cell.delegate = self
    
    cell.post = posts[indexPath.row]
    
    return cell
  }
  
  //  MARK: - FeedCellDelegate Protocol
  
  func handleUsernameTapped(for cell: FeedCell) {

    guard let post = cell.post else { return }
    
    let userProfileVC = UserProfileVC(collectionViewLayout: UICollectionViewFlowLayout())
    
    userProfileVC.user = post.user
    
    navigationController?.pushViewController(userProfileVC, animated: true)
  }
  
  func handleOptionsTapped(for cell: FeedCell) {
    print("Handle options tapped")
  }
  
  func handleLikeTapped(for cell: FeedCell) {
    print("Handle like tapped")
  }
  
  func handleCommentTapped(for cell: FeedCell) {
    print("Handle comment tapped")
  }
  
  //  MARK: - Handlers
  
  @objc func handleShowMessages() {
    print("Handle show messages")
  }
  
  func configureNavigationBar() {
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
    
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "send2"), style: .plain, target: self, action: #selector(handleShowMessages))
    
    self.navigationItem.title = "Feed"
  }
  
  @objc func handleLogout() {
    
//    declare alert controller
    let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    
//    add alert log out action
    alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
      
      do {
//        attempt sign out
        try Auth.auth().signOut()
        
//        present login controller
        let loginVC = LoginVC()
        let navController = UINavigationController(rootViewController: loginVC)
        self.present(navController, animated: true, completion: nil)
        
        print("Successfully logged user out")
  
      } catch {
//        handle error
        print("Failed to sign out")
      }
    }))
    
//    add cancel action
    alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    
    present(alertController, animated: true, completion: nil)
    
  }
  
  //  MARK: - API
  
  func fetchPosts() {
    
    POSTS_REF.observe(.childAdded) { (snapshot) in
      
      let postId = snapshot.key
      
      Database.fetchPost(with: postId, completion: { (post) in
        
        self.posts.append(post)
        
        self.posts.sort(by: { (post1, post2) -> Bool in
          return post1.creationDate > post2.creationDate
        })
        
        self.collectionView?.reloadData()
      })
    }
  }
}
