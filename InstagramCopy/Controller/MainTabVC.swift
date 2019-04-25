//
//  MainTabVC.swift
//  InstagramCopy
//
//  Created by Elizeu RS on 20/04/19.
//  Copyright © 2019 elizeurs. All rights reserved.
//

import UIKit
import Firebase

class MainTabVC: UITabBarController, UITabBarControllerDelegate {
  
  //  MARK: - Properties

    override func viewDidLoad() {
        super.viewDidLoad()

//      delegate
      self.delegate = self
      
//      configure view controller
      configureViewControllers()
      
//  user validation
      checkIfUserIsLoggedIn()
    }
  
  //  MARK: - Handlers
  
//  function to create view controllers that exist within tab bar controller
  func configureViewControllers() {
  
//    home feed controller
    let feedVC = constructNavController(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: FeedVC(collectionViewLayout: UICollectionViewFlowLayout()))
    
//    search feed controller
    let searchVC = constructNavController(unselectedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"), rootViewController: SearchVC())
    
//    post controller
    let uploadPostVC = constructNavController(unselectedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"), rootViewController: UploadPostVC())
    
//    notification controller
    let notificationVC = constructNavController(unselectedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"), rootViewController: NotificationsVC())
    
//    profile controller
    let userProfileVC = constructNavController(unselectedImage: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected"), rootViewController: UserProfileVC(collectionViewLayout: UICollectionViewFlowLayout()))
    
//    view controller to be added to tab controller
    viewControllers = [feedVC, searchVC, uploadPostVC, notificationVC, userProfileVC]
    
//    tab bar tint color
    tabBar.tintColor = .black
  }
  
// construct navigation controller
  func constructNavController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
    
//    construct nav controller
    let navController = UINavigationController(rootViewController: rootViewController)
    navController.tabBarItem.image = unselectedImage
    navController.tabBarItem.selectedImage = selectedImage
    navController.navigationBar.tintColor = .black
    
//    return nav controller
    return navController
  }
  
  func checkIfUserIsLoggedIn() {
    
    if Auth.auth().currentUser == nil {
      DispatchQueue.main.async {
//        present login controller
        let loginVC = LoginVC()
        let navController = UINavigationController(rootViewController: loginVC)
        self.present(navController, animated: true, completion: nil)
      }
      return
    }
  }
}
