//
//  SettingsViewController.swift
//  RevenueCatTracker
//
//  Created by Joan Cardona on 25/1/21.
//

import Foundation
import UIKit
import MessageUI

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
    
    func recommendToFriend() {
        let textToShare = "I found this beautiful RevenueCat client and I thought you would be interested too"
        if let myWebsite = NSURL(string: "https://apps.apple.com/us/app/mindful-affirmations/id1473019675") {
            let objectsToShare: [Any] = [textToShare, myWebsite]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    func sendEmail() {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func prettifyTransactions() {
        let alert = UIAlertController(title: "Coming soon!", message: "This is not yet developed. We are working on it so be sure to check it in the next version", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (_) in
            alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func openForReview() {
        if let url = URL(string: "itms-apps://itunes.apple.com/app/id1473019675?action=write-review"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let sectionCase = SettingsViewModel.Section.allCases[indexPath.section]
        let data = viewModel.rowsPerSection(sectionCase, for: viewModel.data)[indexPath.row]
        data.action()
    }
}

extension SettingsViewController: MFMailComposeViewControllerDelegate {
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Uknown"
        mailComposerVC.setToRecipients(["joancardona@gmail.com"])
        mailComposerVC.setSubject("Help & Support")
        mailComposerVC.setMessageBody("Hello!" + "\n\n" + "App version: \(appVersion)", isHTML: false)

        return mailComposerVC
    }

    func showSendMailErrorAlert() {
        let emailErrorAlert = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle: .alert)
        emailErrorAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(emailErrorAlert, animated: true, completion: nil)
    }

    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
