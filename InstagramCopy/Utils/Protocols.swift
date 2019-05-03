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
}
