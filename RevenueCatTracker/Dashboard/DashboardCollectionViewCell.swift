//
//  DashboardCollectionViewCell.swift
//  RevenueCatTracker
//
//  Created by Joan Cardona on 25/1/21.
//

import Foundation
import UIKit

class DashboardCollectionViewCell: UICollectionViewCell {
    static let kIdentifier = "kDashboardCollectionViewCell"
    
    let container: UIView = {
        return UIView()
    }()
    
    private lazy var valueLabel: UILabel = {
        let l = UILabel()
        l.textColor = .black
        l.font = UIFont.preferredFont(forTextStyle: .title1)
        l.numberOfLines = 0
        l.textAlignment = .left
        l.allowsDefaultTighteningForTruncation = true
        return l
    }()
    
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.textColor = .black
        l.font = UIFont.preferredFont(forTextStyle: .body)
        l.numberOfLines = 0
        l.textAlignment = .left
        l.allowsDefaultTighteningForTruncation = true
        return l
    }()
    
    var value: String? {
        didSet {
            valueLabel.text = value
        }
    }
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.addSubview(container)
        container.addSubview(valueLabel)
        container.addSubview(titleLabel)
        
        container.snp.makeConstraints { (make) in
            make.center.width.equalToSuperview()
            make.height.lessThanOrEqualToSuperview()
        }
        
        valueLabel.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(valueLabel.snp.bottom).offset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
