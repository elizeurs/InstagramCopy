//
//  Protocols.swift
//  InstagramCopy
//
//  Created by Elizeu RS on 01/05/19.
//  Copyright © 2019 elizeurs. All rights reserved.
//

import Foundation

protocol UserProfileHeaderDelegate {
  
  func handleEditFollowTapped(for header: UserProfileHeader)
  func setUserStats(for header: UserProfileHeader)
  func handleFollowersTapped(for header: UserProfileHeader)
  func handleFollowingTapped(for header: UserProfileHeader)
}

protocol FollowCellDelegate {
  func handleFollowTapped(for cell: FollowCell)
}

protocol FeedCellDelegate {
  func handleUsernameTapped(for cell: FeedCell)
  func handleOptionsTapped(for cell: FeedCell)
  func handleLikeTapped(for cell: FeedCell)
  func handleCommentTapped(for cell: FeedCell)
}
