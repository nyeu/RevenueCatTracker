//
//  TransactionsViewController.swift
//  RevenueCatTracker
//
//  Created by Joan Cardona on 25/1/21.
//

import Foundation
import UIKit

class TransactionsViewController: UIViewController {
    fileprivate let viewModel: TransactionsViewModel
    fileprivate let transactionView: TransactionsView
    let refresher = UIRefreshControl()

    init(viewModel: TransactionsViewModel) {
        self.viewModel = viewModel
        self.transactionView = TransactionsView()
        super.init(nibName: nil, bundle: nil)
        
        view.addSubview(transactionView)
        transactionView.snp.makeConstraints { (make) in
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
        viewModel.getTransactions()
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
        transactionView.sandboxSwitch.addTarget(self, action: #selector(sandboxSelected), for: .valueChanged)
    }
    
    @objc func sandboxSelected() {
        mainStore.dispatch(MainStateAction.changeSandboxMode(transactionView.sandboxSwitch.isOn))
    }
}

// MARK: StoreSubscriber
extension TransactionsViewController: TransactionsViewModelDelegate {
    func updateView(newState: TransactionsViewModel.TransactionState, oldState: TransactionsViewModel.TransactionState?) {
        transactionView.collectionView.reloadData()
    }
}

// MARK: CollectionView
extension TransactionsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    private func setupCollectionView() {
        transactionView.collectionView.dataSource = self
        transactionView.collectionView.delegate = self
        transactionView.collectionView.backgroundColor = .clear
        transactionView.collectionView.register(TransactionCollectionViewCell.self, forCellWithReuseIdentifier: TransactionCollectionViewCell.kIdentifier)
        transactionView.collectionView.layer.speed = 2.5
        transactionView.collectionView.showsHorizontalScrollIndicator = false
        
        refresher.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        transactionView.collectionView.addSubview(refresher)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.currentState?.transactions?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        return CGSize(width: screenWidth, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TransactionCollectionViewCell.kIdentifier, for: indexPath) as! TransactionCollectionViewCell
        
        guard let transactions = viewModel.currentState?.transactions else { return cell }
        let transaction = transactions[indexPath.row]
        cell.revenue = transaction.isTrial ? "Trial" : String(format: "$%.2f", transaction.revenue)
        cell.appName = transaction.app.name
        cell.productIdentifier = transaction.productIdentifier
        cell.purchaseTag = transaction.tag.prettify().uppercased()
        
        if let tExpiration = transaction.expirationDate, let expirationDate = viewModel.radableDate(date: tExpiration) {
            cell.expiration = "Expires \(expirationDate)"
        } else {
            cell.expiration = "Don't expire"
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let transactions = viewModel.currentState?.transactions, transactions.count > 0, viewModel.fetchState == .ready else {
            return
        }
        if indexPath.row >= transactions.count - 3 {
            viewModel.getMoreTransactions()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let transactions = viewModel.currentState?.transactions else { return }
        let transaction = transactions[indexPath.row]
        mainStore.dispatch(MainStateAction.selectTransaction(transaction))
        let detailTransactionVc = TransactionDetailViewController(viewModel: TransactionDetailViewModel(timeService: TimeService()))
        navigationController?.pushViewController(detailTransactionVc, animated: true)
    }
    
    @objc func refreshData() {
        viewModel.refreshTransactions()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.refresher.endRefreshing()
        }
    }
}

