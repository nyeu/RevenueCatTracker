//
//  DashboardViewController.swift
//  RevenueCatTracker
//
//  Created by Joan Cardona on 24/1/21.
//

import Foundation
import UIKit
import ReSwift

class DashboardViewController: UIViewController {
    fileprivate let viewModel: DashboardViewModel
    
    init(viewModel: DashboardViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mainStore.subscribe(self, transform: {
            $0.select(DashboardViewModel.DashboardState.init)
        })
        viewModel.getOverview()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mainStore.unsubscribe(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}

// MARK: StoreSubscriber
extension DashboardViewController: StoreSubscriber {
    typealias StoreSubscriberStateType = DashboardViewModel.DashboardState
    
    func newState(state: DashboardViewModel.DashboardState) {
        

        viewModel.currentState = state
    }
}
