//
//  UserPostCell.swift
//  InstagramCopy
//
//  Created by Elizeu RS on 16/05/19.
//  Copyright © 2019 elizeurs. All rights reserved.
//

import UIKit

class UserPostCell: UICollectionViewCell {
  
  var post: Post? {
    
    didSet {
      
      print("Did set post")
      
      guard let imageUrl = post?.imageUrl else { return }
      postImageView.loadImage(with: imageUrl)
    }
  }
  
  
  let postImageView: CustomImageView = {
    let iv = CustomImageView()
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    iv.backgroundColor = .lightGray
    return iv
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(postImageView)
    postImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
