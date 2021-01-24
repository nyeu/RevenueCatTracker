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
        l.text = "Log into your account 🐱"
        l.font = UIFont.preferredFont(forTextStyle: .headline)
        return l
    }()
    
    let emailTextField: UITextField = {
        let t = UITextField()
        t.placeholder = "Email"
        t.textColor = .black
        t.keyboardType = .emailAddress
        t.autocapitalizationType = .none
        return t
    }()
    
    let passwordTextField: UITextField = {
        let t = UITextField()
        t.isSecureTextEntry = true
        t.placeholder = "Password"
        t.textColor = .black
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
        b.backgroundColor = .blue
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
        addSubview(stackTextFields)
        addSubview(loginButton)
        
        textFields.forEach({ stackTextFields.addArrangedSubview($0) })
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(30)
            make.centerX.equalToSuperview()
        }
        
        stackTextFields.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.equalTo(120)
            make.width.equalToSuperview().offset(-50)
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-30)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalToSuperview().offset(-50)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}