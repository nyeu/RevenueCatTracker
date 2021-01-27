//
//  LoginViewController.swift
//  RevenueCatTracker
//
//  Created by Joan Cardona on 24/1/21.
//

import Foundation
import UIKit
import SnapKit
import SVProgressHUD

class LoginViewController: UIViewController {
    fileprivate let viewModel: LoginViewModel
    private let loginView: LoginView
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        self.loginView = LoginView()
        super.init(nibName: nil, bundle: nil)
        
        view.addSubview(self.loginView)
        self.loginView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.subscribe()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.unsubscribe()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "ScreenBackgroundColor")
        viewModel.delegate = self
        loginView.textFields.forEach({ $0.delegate = self })
        loginView.loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
    }
    
    @objc func loginTapped() {
        guard let credentials = viewModel.currentState?.credentials, viewModel.validateCredentials(credentials) else {
            return
        }
        SVProgressHUD.show()
        mainStore.dispatch(loginRevenueCat)
    }
    
    func navigateToDashboard() {
        let tabbar = TabbarViewController()
        let nav = UINavigationController(rootViewController: tabbar)
        nav.setNavigationBarHidden(true, animated: false)
        nav.navigationBar.tintColor = UIColor(named: "primary")
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
}

// MARK: LoginViewModelDelegate
extension LoginViewController: LoginViewModelDelegate {
    func updateView(oldState: LoginViewModel.LoginState?, newState: LoginViewModel.LoginState) {
        DispatchQueue.main.async {
            self.loginView.emailTextField.text = newState.credentials?.email
            self.loginView.passwordTextField.text = newState.credentials?.password
            
            if newState.auth != oldState?.auth, let auth = newState.auth {
                switch auth {
                case .success:
                    SVProgressHUD.dismiss()
                    DispatchQueue.main.async {
                        self.navigateToDashboard()
                    }
                case .error(let error):
                    if let e = error {
                        SVProgressHUD.showError(withStatus: e)
                    }
                }
            }
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            
            
            DispatchQueue.main.async {
                switch textField {
                case self.loginView.emailTextField:
                    let credential = Credentials(email: updatedText, password: mainStore.state.credentials?.password ?? "")
                    mainStore.dispatch(MainStateAction.login(credential))
                    
                case self.loginView.passwordTextField:
                    mainStore.dispatch(MainStateAction.login(Credentials(email: mainStore.state.credentials?.email ?? "", password: updatedText)))
                default:
                    break
                }
            }
        }
        
        return false
    }
}

