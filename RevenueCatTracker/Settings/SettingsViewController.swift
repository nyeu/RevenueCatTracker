//
//  SettingsViewController.swift
//  RevenueCatTracker
//
//  Created by Joan Cardona on 25/1/21.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    let viewModel: SettingsViewModel
    let settingsView: SettingsView
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        self.settingsView = SettingsView()
        super.init(nibName: nil, bundle: nil)
        
        view.addSubview(settingsView)
        settingsView.snp.makeConstraints { (make) in
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
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
extension SettingsViewController: SettingsViewModelDelegate {
    func updateView(newState: SettingsViewModel.SettingsState, oldState: SettingsViewModel.SettingsState?) {
        //
    }
}

// MARK: Tableview
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    fileprivate func setupTableView() {
        settingsView.tableView.delegate = self
        settingsView.tableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsViewModel.Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionCase = SettingsViewModel.Section.allCases[section]
        return viewModel.rowsPerSection(sectionCase, for: viewModel.data).count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionCase = SettingsViewModel.Section.allCases[section]
        return sectionCase.rawValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let sectionCase = SettingsViewModel.Section.allCases[indexPath.section]
        let data = viewModel.rowsPerSection(sectionCase, for: viewModel.data)[indexPath.row]
        cell.textLabel?.text = data.rowData.title
        cell.detailTextLabel?.text = data.rowData.detail
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}
