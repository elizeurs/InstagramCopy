//
//  LoginVC.swift
//  InstagramCopy
//
//  Created by Elizeu RS on 15/04/19.
//  Copyright © 2019 elizeurs. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
  
  let logoContainerView: UIView = {
    let view = UIView()
    let logoImageView = UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white"))
    logoImageView.contentMode = .scaleAspectFill
    view.addSubview(logoImageView)
    logoImageView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 50)
    logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    view.backgroundColor = UIColor(red: 0/255, green: 120/255, blue: 175/255, alpha: 1)
    return view
    
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
  
  let loginButton: UIButton = {
    let buttom = UIButton(type: .system)
    buttom.setTitle("Login", for: .normal)
    buttom.setTitleColor(.white, for: .normal)
    buttom.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
    return buttom
  }()
  
  let dontHaveAccountButton: UIButton = {
    let button = UIButton(type: .system)
    
    let attrubutedTitle = NSMutableAttributedString(string: "Don't have an account ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    attrubutedTitle.append(NSAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)]))
    
    button.setAttributedTitle(attrubutedTitle, for: .normal)
    
    return button
  }()

    override func viewDidLoad() {
        super.viewDidLoad()
      
//      background color
      view.backgroundColor = .white
      
      view.addSubview(logoContainerView)
      logoContainerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 150)
      
      configureViewComponents()
      
      view.addSubview(dontHaveAccountButton)
      dontHaveAccountButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
    }
  
  func configureViewComponents() {
    
    let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
    
    stackView.axis = .vertical
    stackView.spacing = 10
    stackView.distribution = .fillEqually
    
    view.addSubview(stackView)
    stackView.anchor(top: logoContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 40, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 140)
    
  }

}
