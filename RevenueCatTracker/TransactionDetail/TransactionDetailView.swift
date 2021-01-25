//
//  TransactionDetailView.swift
//  RevenueCatTracker
//
//  Created by Joan Cardona on 25/1/21.
//

import Foundation
import UIKit

class TransactionDetailView: UIView {
    let tableView: UITableView = {
        let t = UITableView(frame: .zero, style: .insetGrouped)
        t.backgroundColor = .clear
        return t
    }()
        
    init() {
        super.init(frame: .zero)
        addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
