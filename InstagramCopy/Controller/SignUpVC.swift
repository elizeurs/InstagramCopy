//
//  SignUpVC.swift
//  InstagramCopy
//
//  Created by Elizeu RS on 16/04/19.
//  Copyright © 2019 elizeurs. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
  
  let plusPhotoBtn: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(#imageLiteral(resourceName: "plus_photo").withRenderingMode(.alwaysOriginal), for: .normal)
    return button
  }()
  
  let emailTextField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "Email"
    tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
    tf.borderStyle = .roundedRect
    tf.font = UIFont.systemFont(ofSize: 14)
    return tf
  }()
  
  
  let passwordTextField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "Password"
    tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
    tf.borderStyle = .roundedRect
    tf.font = UIFont.systemFont(ofSize: 14)
    return tf
  }()
  
  
  let fullNameTextField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "Full name"
    tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
    tf.borderStyle = .roundedRect
    tf.font = UIFont.systemFont(ofSize: 14)
    return tf
  }()
  
  
  let usernameTextField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "Username"
    tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
    tf.borderStyle = .roundedRect
    tf.font = UIFont.systemFont(ofSize: 14)
    return tf
  }()
  
  let SignUpButton: UIButton = {
    let buttom = UIButton(type: .system)
    buttom.setTitle("Sign Up", for: .normal)
    buttom.setTitleColor(.white, for: .normal)
    buttom.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
    return buttom
  }()
  
  let AlreadyHaveAccountButton: UIButton = {
    let button = UIButton(type: .system)
    
    let attrubutedTitle = NSMutableAttributedString(string: "Already have an account? ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    attrubutedTitle.append(NSAttributedString(string: "Sign In", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)]))
    button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
    button.setAttributedTitle(attrubutedTitle, for: .normal)
    
    return button
  }()
  
  

    override func viewDidLoad() {
        super.viewDidLoad()
      
//      background color
      view.backgroundColor = .white
      
      view.addSubview(plusPhotoBtn)
      plusPhotoBtn.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 140, height: 140)
      plusPhotoBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
      
      configureViewComponents()
      
      view.addSubview(AlreadyHaveAccountButton)
      AlreadyHaveAccountButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)

    }
  
  @objc func handleShowLogin() {
    _ = navigationController?.popViewController(animated: true)
  }
  
  func configureViewComponents() {
    
    let stackView = UIStackView(arrangedSubviews: [emailTextField, fullNameTextField, usernameTextField, passwordTextField, SignUpButton])
    
    stackView.axis = .vertical
    stackView.spacing = 10
    stackView.distribution = .fillEqually
    
    view.addSubview(stackView)
    stackView.anchor(top: plusPhotoBtn.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 24, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 240)
    
  }


}
