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
        
        mainStore.subscribe(self, transform: {
            $0.select(LandingViewModel.LandingState.init)
        })
        viewModel.retrieveAuth()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mainStore.unsubscribe(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

// MARK: StoreSubscriber
extension LandingViewController: StoreSubscriber {
    typealias StoreSubscriberStateType = LandingViewModel.LandingState
    
    func newState(state: LandingViewModel.LandingState) {
        if viewModel.currentState?.auth == nil && state.auth != nil, let auth = state.auth {
            DispatchQueue.main.async {
                switch auth {
                case .success:
                    self.navigateToDashboard()
                case .error:
                    self.navigateToLogin()
                }
            }
        }
        
        viewModel.currentState = state
    }
}
