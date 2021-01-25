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
        let v = UIView()
        v.backgroundColor = UIColor(named: "ClearBackgroundColor")
        v.layer.cornerRadius = 10.0
        v.layer.masksToBounds = true
        v.layer.borderWidth = 2.0
        v.layer.borderColor = UIColor.gray.cgColor
        return v
    }()
    
    private lazy var valueLabel: UILabel = {
        let l = UILabel()
        l.textColor = UIColor(named: "primaryText")
        l.font = UIFont.preferredFont(forTextStyle: .title1)
        l.numberOfLines = 0
        l.textAlignment = .center
        l.allowsDefaultTighteningForTruncation = true
        l.adjustsFontForContentSizeCategory = true
        return l
    }()
    
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.textColor = UIColor(named: "primaryText")
        l.font = UIFont.preferredFont(forTextStyle: .body)
        l.numberOfLines = 0
        l.textAlignment = .center
        l.allowsDefaultTighteningForTruncation = true
        l.adjustsFontForContentSizeCategory = true
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
            make.right.equalToSuperview().offset(-16)
            make.top.left.equalToSuperview().offset(16)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.bottom.right.equalToSuperview().offset(-16)
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(valueLabel.snp.bottom).offset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
