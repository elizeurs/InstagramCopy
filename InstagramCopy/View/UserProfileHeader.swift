//
//  UserProfileHeader.swift
//  InstagramCopy
//
//  Created by Elizeu RS on 22/04/19.
//  Copyright © 2019 elizeurs. All rights reserved.
//

import UIKit
import Firebase

class UserProfileHeader: UICollectionViewCell {
  
  var user: User? {
    
    didSet {
      
//      configure edit profile buttom
      configureEditProfileFollowBotton()
      
      let fullName = user?.name
      nameLabel.text = fullName
      
      guard let profileImageUrl = user?.profileImageUrl else { return }
      
      profileImageView.loadImage(with: profileImageUrl)
    }
  }
  
  
  let profileImageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    iv.backgroundColor = .lightGray
    return iv
  }()
  
  let nameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 12)
    return label
  }()
  
  let postsLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textAlignment = .center
    let attributedText = NSMutableAttributedString(string: "5\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
    attributedText.append(NSAttributedString(string: "posts", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
    label.attributedText = attributedText
    return label
  }()
  
  let followersLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textAlignment = .center
    let attributedText = NSMutableAttributedString(string: "5\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
    attributedText.append(NSAttributedString(string: "followers", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
    label.attributedText = attributedText
    return label
  }()
  
  let followingLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textAlignment = .center
    let attributedText = NSMutableAttributedString(string: "5\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
    attributedText.append(NSAttributedString(string: "following", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
    label.attributedText = attributedText
    return label
  }()
  
  let editProfileFollowButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Loading", for: .normal)
    button.layer.cornerRadius = 3
    button.layer.borderColor = UIColor.lightGray.cgColor
    button.layer.borderWidth = 0.5
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    button.setTitleColor(.black, for: .normal)
    return button
  }()
  
  let gridButton: UIButton = {
    let Button = UIButton(type: .system)
    Button.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
    return Button
  }()
  
  let listButton: UIButton = {
    let Button = UIButton(type: .system)
    Button.setImage(#imageLiteral(resourceName: "list"), for: .normal)
    return Button
  }()
  
  let bookmarkButton: UIButton = {
    let Button = UIButton(type: .system)
    Button.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
    return Button
  }()
  
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  
    addSubview(profileImageView)
    profileImageView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 80, height: 80)
    profileImageView.layer.cornerRadius = 80 / 2
    
    addSubview(nameLabel)
    nameLabel.anchor(top: profileImageView.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
    configureUserStats()
    
    addSubview(editProfileFollowButton)
    editProfileFollowButton.anchor(top: postsLabel.bottomAnchor, left: postsLabel.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 4, paddingLeft: 8, paddingBottom: 0, paddingRight: 12, width: 0, height: 30)
    
    configureBottomToolBar()
    
  }
  
  func configureBottomToolBar() {
    
    let topDividerView = UIView()
    topDividerView.backgroundColor = .lightGray
    
    let bottomDividerView = UIView()
    bottomDividerView.backgroundColor = .lightGray
    
    let stackView = UIStackView(arrangedSubviews: [gridButton, listButton, bookmarkButton])
    
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    
    addSubview(stackView)
    addSubview(topDividerView)
    addSubview(bottomDividerView)
    
    stackView.anchor(top: nil, left: leftAnchor, bottom: self.bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
    
    topDividerView.anchor(top: stackView.topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
    
    bottomDividerView.anchor(top: stackView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
  }
  
  func configureUserStats() {
    
    let stackView = UIStackView(arrangedSubviews: [postsLabel, followingLabel, followersLabel])
    
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    
    addSubview(stackView)
    stackView.anchor(top: topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 50)
    
  }
  
  func configureEditProfileFollowBotton() {
    
    guard let currentUid = Auth.auth().currentUser?.uid else { return }
    guard  let user = self.user else { return }
    
    if  currentUid == user.uid {
      
//      configure button as edit profile
      editProfileFollowButton.setTitle("Edit Profile", for: .normal)
      
    } else {
      
//      configure button as follow button
      editProfileFollowButton.setTitle("Follow", for: .normal)
      editProfileFollowButton.setTitleColor(.white, for: .normal)
      editProfileFollowButton.backgroundColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
