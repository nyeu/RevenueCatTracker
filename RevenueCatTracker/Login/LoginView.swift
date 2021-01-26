//
//  LoginView.swift
//  RevenueCatTracker
//
//  Created by Joan Cardona on 24/1/21.
//

import Foundation
import UIKit

class LoginView: UIView {
    
    let iconImageView: UIImageView = {
        let i = UIImageView()
        return i
    }()
    
    let titleLabel: UILabel = {
        let l = UILabel()
        l.text = "RC Tracker"
        l.font = UIFont.preferredFont(forTextStyle: .largeTitle).bold()
        l.textColor = UIColor(named: "primary")
        l.numberOfLines = 0
        l.textAlignment = .center
        return l
    }()
    
    let messageLabel: UILabel = {
        let l = UILabel()
        l.text = "Log into your RevenueCat Account 🐱"
        l.font = UIFont.preferredFont(forTextStyle: .headline)
        l.textColor = UIColor(named: "primaryText")
        l.numberOfLines = 0
        return l
    }()
    
    let messageDetailsLabel: UILabel = {
        let l = UILabel()
        l.text = "We don't store any data about your account and we communicate directly with RevenueCat API"
        l.font = UIFont.preferredFont(forTextStyle: .subheadline)
        l.numberOfLines = 0
        l.textColor = UIColor(named: "primaryText")
        return l
    }()
    
    let emailTextField: UITextField = {
        let t = UITextField()
        t.placeholder = "Email"
        t.textColor = UIColor(named: "primaryText")
        t.keyboardType = .emailAddress
        t.autocapitalizationType = .none
        return t
    }()
    
    let passwordTextField: UITextField = {
        let t = UITextField()
        t.isSecureTextEntry = true
        t.placeholder = "Password"
        t.textColor = UIColor(named: "primaryText")
        return t
    }()
    
    let stackTextFields: UIStackView = {
        let s = UIStackView()
        s.axis = .vertical
        s.distribution = .fillEqually
        s.spacing = 20
        return s
    }()
    
    let loginButton: UIButton = {
        let b = UIButton()
        b.setTitle("Log in", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.backgroundColor = UIColor(named: "primary")
        b.layer.cornerRadius = 10.0
        b.layer.masksToBounds = true
        b.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline).bold()
        return b
    }()
    
    var textFields: [UITextField] {
        return [emailTextField,
                passwordTextField]
    }
    
    init() {
        super.init(frame: .zero)
        
        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(messageLabel)
        addSubview(messageDetailsLabel)
        addSubview(stackTextFields)
        addSubview(loginButton)
        
        textFields.forEach({ stackTextFields.addArrangedSubview($0) })
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(32)
            make.width.equalToSuperview().offset(-50)
            make.centerX.equalToSuperview()
        }
        
        messageLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(messageDetailsLabel.snp.top).offset(-16)
            make.width.equalToSuperview().offset(-50)
            make.centerX.equalToSuperview()
        }
        
        messageDetailsLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(stackTextFields.snp.top).offset(-32)
            make.width.equalToSuperview().offset(-50)
            make.centerX.equalToSuperview()
        }
        
        stackTextFields.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.equalTo(120)
            make.width.equalToSuperview().offset(-50)
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-32)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalToSuperview().offset(-50)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
