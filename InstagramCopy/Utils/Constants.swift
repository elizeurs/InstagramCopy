//
//  Constants.swift
//  InstagramCopy
//
//  Created by Elizeu RS on 18/04/19.
//  Copyright © 2019 elizeurs. All rights reserved.
//

import Firebase


let DB_REF = Database.database().reference()
let STORAGE_REF = Storage.storage().reference()

let USER_REF = DB_REF.child("users")

let USER_FOLLOWER_REF = DB_REF.child("user-followers")
let USER_FOLLOWING_REF = DB_REF.child("user-following")

let POSTS_REF = DB_REF.child("posts")
let USER_POSTS_REF = DB_REF.child("user-posts")

let USER_FEED_REF = DB_REF.child("user-feed")

let USER_LIKES_REF = DB_REF.child("user-likes")
let POST_LIKES_REF = DB_REF.child("post-likes")


// MARK: - Storage References

let STORAGE_POST_IMAGES_REF = STORAGE_REF.child("post_images")




