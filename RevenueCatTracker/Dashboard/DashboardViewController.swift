//
//  DashboardViewController.swift
//  RevenueCatTracker
//
//  Created by Joan Cardona on 24/1/21.
//

import Foundation
import UIKit

class DashboardViewController: UIViewController {
    fileprivate let viewModel: DashboardViewModel
    fileprivate let dashboardView: DashboardView
    let refresher = UIRefreshControl()

    init(viewModel: DashboardViewModel) {
        self.viewModel = viewModel
        self.dashboardView = DashboardView()
        super.init(nibName: nil, bundle: nil)
        
        view.addSubview(dashboardView)
        dashboardView.snp.makeConstraints { (make) in
            make.top.equalTo(view.layoutMarginsGuide.snp.top)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.layoutMarginsGuide.snp.bottom)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.subscribe()
        viewModel.getOverview()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.unsubscribe()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "ScreenBackgroundColor")
        viewModel.delegate = self
        setupCollectionView()
    }
    
    func navigateToLogin() {
        DispatchQueue.main.async {
            let logingVC = LoginViewController(viewModel: LoginViewModel(validator: Validator()))
            logingVC.modalPresentationStyle = .fullScreen
            self.present(logingVC, animated: true, completion: nil)
        }
    }
}

extension DashboardViewController: DashboardViewModelDelegate {
    func updateView(newState: DashboardViewModel.DashboardState, oldState: DashboardViewModel.DashboardState?) {
        guard tokenIsValid(state: newState) else {
            return
        }
        dashboardView.collectionView.reloadData()
    }
    
    private func tokenIsValid(state: DashboardViewModel.DashboardState) -> Bool {
        guard let auth = state.auth else {
            return false
        }
        switch auth {
        case .success:
            return true
        default:
            self.navigateToLogin()
            return false
        }
    }
}

// MARK: CollectionView
extension DashboardViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    private func setupCollectionView() {
        dashboardView.collectionView.dataSource = self
        dashboardView.collectionView.delegate = self
        dashboardView.collectionView.backgroundColor = .clear
        dashboardView.collectionView.register(DashboardCollectionViewCell.self, forCellWithReuseIdentifier: DashboardCollectionViewCell.kIdentifier)
        dashboardView.collectionView.layer.speed = 2.5
        dashboardView.collectionView.showsHorizontalScrollIndicator = false
        
        refresher.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        dashboardView.collectionView.addSubview(refresher)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.currentState?.overview?.orderedKeys.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DashboardCollectionViewCell.kIdentifier, for: indexPath) as! DashboardCollectionViewCell
        
        guard let overview = viewModel.currentState?.overview else { return cell }
        let key = overview.orderedKeys[indexPath.row]
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 0
        numberFormatter.currencySymbol = "$"
        
        switch key {
        case Overview.CodingKeys.revenue:
            cell.value = numberFormatter.string(from: NSNumber(floatLiteral: overview.revenue))
            cell.title = "Revenue"
        case Overview.CodingKeys.mrr:
            cell.value = numberFormatter.string(from: NSNumber(floatLiteral: overview.mrr))
            cell.title = "MRR"
        case .activeSubscribers:
            cell.value = String(overview.activeSubscribers)
            cell.title = "Active Subscribers"
        case .activeTrials:
            cell.value = String(overview.activeTrials)
            cell.title = "Active Trials"
        case .activeUsers:
            cell.value = String(overview.activeUsers)
            cell.title = "Active Users"
        case .installs:
            cell.value = String(overview.installs)
            cell.title = "Installs"
        }
        
        return cell
    }
    
    @objc func refreshData() {
        viewModel.getOverview()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.refresher.endRefreshing()
        }
    }
}
