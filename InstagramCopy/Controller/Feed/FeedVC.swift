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
  var viewSinglePost = false
  var post: Post?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView?.backgroundColor = .white
    
    // register cell classes
    self.collectionView!.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    
//    configure refresh control
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
    collectionView?.refreshControl = refreshControl
    
    //      configure  logout button
    configureNavigationBar()
    
//    fetch posts
    if !viewSinglePost {
      fetchPosts()
    }
    
    updateUserFeeds()
    
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
    
    if viewSinglePost {
      return 1
    } else {
      return posts.count
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell
    
    cell.delegate = self
    
    if viewSinglePost {
      if let post = self.post {
        cell.post = post
      }
    } else {
        cell.post = posts[indexPath.item]
    }
    
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
  
  @objc func handleRefresh() {
    posts.removeAll(keepingCapacity: false)
    fetchPosts()
    collectionView?.reloadData()
  }
  
  @objc func handleShowMessages() {
    print("Handle show messages")
  }
  
  func configureNavigationBar() {
    
    if !viewSinglePost {
          self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
    }
    
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
  
  func updateUserFeeds() {
    
    guard let currentUid = Auth.auth().currentUser?.uid else { return }
    
    USER_FOLLOWING_REF.child(currentUid).observe(.childAdded) { (snapshot) in
      
      let followingUserId = snapshot.key
      
      USER_POSTS_REF.child(followingUserId).observe(.childAdded, with: { (snaphot) in
        
        let postId = snapshot.key
        
        USER_FEED_REF.child(currentUid).updateChildValues([postId: 1])
        
      })
    }
    
    USER_POSTS_REF.child(currentUid).observe(.childAdded) { (snaphot) in
      
      let postId = snaphot.key
      
      USER_FEED_REF.child(currentUid).updateChildValues([postId: 1])
      
    }
  }
  
  func fetchPosts() {
    
    guard let currentId = Auth.auth().currentUser?.uid else { return }
    
    USER_FEED_REF.child(currentId).observe(.childAdded) { (snapshot) in
      
      let postId = snapshot.key
      
      Database.fetchPost(with: postId, completion: { (post) in
        
        self.posts.append(post)
        
        self.posts.sort(by: { (post1, post2) -> Bool in
          return post1.creationDate > post2.creationDate
        })
        
//        stop refreshing
        self.collectionView?.refreshControl?.endRefreshing()
        
        self.collectionView?.reloadData()
      })
    }
  }
}
