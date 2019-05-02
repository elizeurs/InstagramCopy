//
//  User.swift
//  InstagramCopy
//
//  Created by Elizeu RS on 23/04/19.
//  Copyright © 2019 elizeurs. All rights reserved.
//

import Firebase

class User {
  
//  attributes
  var username: String!
  var name: String!
  var profileImageUrl: String!
  var uid: String!
  var isFollowed = false
  
  
  init(uid: String, dictionary: Dictionary<String, AnyObject>) {
    
    self.uid = uid
    
    if let username = dictionary["username"] as? String {
      self.username = username
    }
    
    if let name = dictionary["name"] as? String {
      self.name = name
    }
    
    if let profileImageUrl = dictionary["profileImageUrl"] as? String {
      self.profileImageUrl = profileImageUrl
    }
  }
  
  func follow() {
    
    guard let currentUid = Auth.auth().currentUser?.uid  else { return }
    
//    set is followed to true
    self.isFollowed = true
    
//    add followed user to current user-following structure
    USER_FOLLOWING_REF.child(currentUid).updateChildValues([self.uid: 1])
    
//    add current user to followed user-follower structure
    USER_FOLLOWER_REF.child(self.uid).updateChildValues([currentUid: 1])
  }
  
  func unfollow() {
    
    guard let currentUid = Auth.auth().currentUser?.uid else { return }
    
//    set is followed to false
    self.isFollowed = false
    
//    remove user from current user-following structure
    USER_FOLLOWING_REF.child(currentUid).child(self.uid).removeValue()
    
//    remove current user from user-following structure
    USER_FOLLOWER_REF.child(self.uid).child(currentUid).removeValue()
  }
  
  func checkIfUserIsFollowed(completion: @escaping(Bool) ->()) {
    
    guard let currentUid = Auth.auth().currentUser?.uid else { return }
    
    USER_FOLLOWING_REF.child(currentUid).observeSingleEvent(of: .value) { (snapshot) in
      
      if snapshot.hasChild(self.uid) {
        
        self.isFollowed = true
        completion(true)
      } else {
        
        self.isFollowed = false
        completion(false)
      }
    }
  }
}
