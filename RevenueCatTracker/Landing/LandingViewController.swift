//
//  LandingViewController.swift
//  RevenueCatTracker
//
//  Created by Joan Cardona on 24/1/21.
//

import Foundation
import UIKit
import ReSwift

class LandingViewController: UIViewController {
    let viewModel: LandingViewModel
    private let landingView: LandingView
    
    init(viewModel: LandingViewModel) {
        self.viewModel = viewModel
        self.landingView = LandingView()
        super.init(nibName: nil, bundle: nil)
        
        view.addSubview(landingView)
        landingView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.subscribe()
        viewModel.retrieveAuth()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.unsubscribe()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        view.backgroundColor = UIColor(named: "ScreenBackgroundColor")
    }
    
    func navigateToDashboard() {
        let tabbar = TabbarViewController()
        let nav = UINavigationController(rootViewController: tabbar)
        nav.setNavigationBarHidden(true, animated: false)
        nav.navigationBar.tintColor = UIColor(named: "primary")
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    func navigateToLogin() {
        let logingVC = LoginViewController(viewModel: LoginViewModel(validator: Validator()))
        logingVC.modalPresentationStyle = .fullScreen
        present(logingVC, animated: true, completion: nil)
    }
}

// MARK: LandingViewModelDelegate
extension LandingViewController: LandingViewModelDelegate {
    func updateView(oldState: LandingViewModel.LandingState?, newState: LandingViewModel.LandingState) {
        if oldState?.auth == nil && newState.auth != nil, let auth = newState.auth {
            DispatchQueue.main.async {
                switch auth {
                case .success:
                    self.navigateToDashboard()
                case .error:
                    self.navigateToLogin()
                }
            }
        }
    }
}
