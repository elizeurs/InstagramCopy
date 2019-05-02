//
//  Constants.swift
//  InstagramCopy
//
//  Created by Elizeu RS on 18/04/19.
//  Copyright © 2019 elizeurs. All rights reserved.
//

import Firebase


let DB_REF = Database.database().reference()




let USER_REF = DB_REF.child("users")

let USER_FOLLOWER_REF = DB_REF.child("user-followers")
let USER_FOLLOWING_REF = DB_REF.child("user-following")
