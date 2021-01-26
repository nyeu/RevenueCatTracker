//
//  TabbarViewController.swift
//  RevenueCatTracker
//
//  Created by Joan Cardona on 25/1/21.
//

import Foundation
import UIKit

class TabbarViewController: UITabBarController, UITabBarControllerDelegate {
    var dashboardViewController: DashboardViewController!
    var transactionsViewController: TransactionsViewController!
    var settingsViewController: SettingsViewController!

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = UIColor(named: "primary")
        tabBar.barTintColor = .white
        tabBar.backgroundColor = .white
        tabBar.isTranslucent = false

        //Remove top line
        let appearance = tabBar.standardAppearance
        appearance.shadowImage = nil
        appearance.shadowColor = nil
        appearance.backgroundColor = UIColor(named: "ClearBackgroundColor")
        tabBar.standardAppearance = appearance
       
        dashboardViewController = DashboardViewController(viewModel: DashboardViewModel())
        let dashTabBar = UITabBarItem(title: "Dashboard", image: UIImage(systemName: "bolt.circle"), selectedImage: UIImage(systemName: "bolt.circle"))
        dashboardViewController.tabBarItem = dashTabBar
        
        transactionsViewController = TransactionsViewController(viewModel: TransactionsViewModel(timeService: TimeService()))
        let transTabBar = UITabBarItem(title: "Transactions", image: UIImage(systemName: "arrow.right.arrow.left.circle"), selectedImage: UIImage(systemName: "arrow.right.arrow.left.circle"))
        transactionsViewController.tabBarItem = transTabBar
        
        settingsViewController = SettingsViewController(viewModel: SettingsViewModel())
        let settTabBar = UITabBarItem(title: "Settings", image: UIImage(systemName: "speedometer"), selectedImage: UIImage(systemName: "speedometer"))
        settingsViewController.tabBarItem = settTabBar
        
        self.viewControllers = [dashboardViewController,
                                transactionsViewController,
                                settingsViewController]
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

