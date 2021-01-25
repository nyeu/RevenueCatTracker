//
//  TransactionDetailViewController.swift
//  RevenueCatTracker
//
//  Created by Joan Cardona on 25/1/21.
//

import Foundation
import UIKit

class TransactionDetailViewController: UIViewController {
    let viewModel: TransactionDetailViewModel
    let transactionDetailView: TransactionDetailView
    
    init(viewModel: TransactionDetailViewModel) {
        self.viewModel = viewModel
        self.transactionDetailView = TransactionDetailView()
        super.init(nibName: nil, bundle: nil)
        
        view.addSubview(transactionDetailView)
        transactionDetailView.snp.makeConstraints { (make) in
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
        navigationController?.setNavigationBarHidden(false, animated: true)
        viewModel.subscribe()
        viewModel.getSubscriber()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        viewModel.unsubscribe()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "ScreenBackgroundColor")
        viewModel.delegate = self
        setupTableView()
    }
}

// MARK: StoreSubscriber
extension TransactionDetailViewController: TransactionDetailViewModelDelegate {
    func updateView(newState: TransactionDetailViewModel.TransactionDetailState, oldState: TransactionDetailViewModel.TransactionDetailState?) {
        self.title = newState.selectedTransaction?.subscriberId
        self.transactionDetailView.tableView.reloadData()
    }
}

// MARK: Tableview
extension TransactionDetailViewController: UITableViewDelegate, UITableViewDataSource {
    fileprivate func setupTableView() {
        transactionDetailView.tableView.delegate = self
        transactionDetailView.tableView.dataSource = self
        transactionDetailView.tableView.rowHeight = UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return TransactionDetailViewModel.Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionCase = TransactionDetailViewModel.Section.allCases[section]
        return viewModel.rowsPerSection(sectionCase, for: viewModel.data).count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionCase = TransactionDetailViewModel.Section.allCases[section]
        return sectionCase.rawValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let sectionCase = TransactionDetailViewModel.Section.allCases[indexPath.section]
        let data = viewModel.rowsPerSection(sectionCase, for: viewModel.data)[indexPath.row]
        cell.textLabel?.text = data.rowData.title
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = data.rowData.detail
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionCase = TransactionDetailViewModel.Section.allCases[indexPath.section]
        let data = viewModel.rowsPerSection(sectionCase, for: viewModel.data)[indexPath.row]
        UIPasteboard.general.string = data.rowData.title
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
