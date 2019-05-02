//
//  UserProfileVC.swift
//  InstagramCopy
//
//  Created by Elizeu RS on 20/04/19.
//  Copyright © 2019 elizeurs. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"
private let headerIdentifier = "UserProfileHeader"

class UserProfileVC: UICollectionViewController, UICollectionViewDelegateFlowLayout, UserProfileHeaderDelegate {

  
  
  //  MARK: - Properties
  
  var currentUser: User?
  var userToLoadFromSearchVC: User?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Register cell classes
    self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    self.collectionView!.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
    
//    background color
    self.collectionView?.backgroundColor = .white
    
    //      fetch user data
    if userToLoadFromSearchVC == nil {
      fetchCurrentUserData()
    }
  }
  
  // MARK: UICollectionView
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of items
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: view.frame.width, height: 200)
  }
  
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
  
//    declare header
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! UserProfileHeader
    
//    set delegate
    header.delegate = self
    
//    set the user in header
    if let user = self.currentUser {
        header.user = user
    } else if let userToLoadFromSearchVC = self.userToLoadFromSearchVC {
      header.user = userToLoadFromSearchVC
      navigationItem.title = userToLoadFromSearchVC.username
    }

    
//    return header
    return header
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
    return cell
  }
  
  //  MARK: - UserProfileHeader
  
  func handleEditFollowTapped(for header: UserProfileHeader) {
    
    guard let user = header.user else { return }
    
    if header.editProfileFollowButton.titleLabel?.text == "Edit Profile" {
      
      let editProfileController = EditProfileController()
      editProfileController.user = user
      editProfileController.userProfileController = self
      let navigationController = UINavigationController(rootViewController: editProfileController)
      present(navigationController, animated: true, completion: nil)
      
    } else {
      
      if header.editProfileFollowButton.titleLabel?.text == "Follow" {
        header.editProfileFollowButton.setTitle("Following", for: .normal)
        user.follow()
      } else {
        header.editProfileFollowButton.setTitle("Follow", for: .normal)
        user.unfollow()
      }
    }
  }
  
  //  MARK: - API
  
  func fetchCurrentUserData() {
    
    guard let currentUid = Auth.auth().currentUser?.uid else { return }
    
    Database.database().reference().child("users").child(currentUid).observeSingleEvent(of: .value) { (snapshot) in
      guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else { return }
      let uid = snapshot.key
      let user = User(uid: uid, dictionary: dictionary)
      self.currentUser = user
      self.navigationItem.title = user.username
      self.collectionView?.reloadData()
    }
    
  }
}
