//
//  TransactionCollectionViewCell.swift
//  RevenueCatTracker
//
//  Created by Joan Cardona on 25/1/21.
//

import Foundation
import UIKit

class TransactionCollectionViewCell: UICollectionViewCell {
    static let kIdentifier = "kTransactionCollectionViewCell"
    
    let container: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(named: "ClearBackgroundColor")
        v.layer.cornerRadius = 10.0
        v.layer.masksToBounds = true
        return v
    }()
    
    let containerStackView: UIStackView = {
        let s = UIStackView()
        s.axis = .horizontal
        s.distribution = .fillEqually
        s.spacing = 10
        return s
    }()
    
    let rightStackView: UIStackView = {
        let s = UIStackView()
        s.axis = .vertical
        s.distribution = .fillProportionally
        s.spacing = 10
        return s
    }()
    
    let leftStackView: UIStackView = {
        let s = UIStackView()
        s.axis = .vertical
        s.distribution = .fillProportionally
        s.spacing = 10
        return s
    }()
    
    private lazy var appNameLabel: UILabel = {
        let l = UILabel()
        l.textColor = UIColor(named: "primaryText")
        l.font = UIFont.preferredFont(forTextStyle: .title2)
        l.numberOfLines = 0
        l.textAlignment = .left
        l.allowsDefaultTighteningForTruncation = true
        l.adjustsFontForContentSizeCategory = true
        return l
    }()
    
    private lazy var revenueLabel: UILabel = {
        let l = UILabel()
        l.textColor = UIColor(named: "primaryText")
        l.font = UIFont.preferredFont(forTextStyle: .title3)
        l.numberOfLines = 0
        l.textAlignment = .right
        l.allowsDefaultTighteningForTruncation = true
        l.adjustsFontForContentSizeCategory = true
        return l
    }()
    
    private lazy var tagLabel: UILabel = {
        let l = UILabel()
        l.textColor = UIColor(named: "primaryText")
        l.font = UIFont.preferredFont(forTextStyle: .subheadline)
        l.numberOfLines = 0
        l.textAlignment = .right
        l.allowsDefaultTighteningForTruncation = true
        l.adjustsFontForContentSizeCategory = true
        return l
    }()
    
    private lazy var productIdentifierLabel: UILabel = {
        let l = UILabel()
        l.textColor = UIColor(named: "primaryText")
        l.font = UIFont.preferredFont(forTextStyle: .subheadline)
        l.numberOfLines = 0
        l.textAlignment = .left
        l.allowsDefaultTighteningForTruncation = true
        l.adjustsFontForContentSizeCategory = true
        return l
    }()
    
    private lazy var expirationLabel: UILabel = {
        let l = UILabel()
        l.textColor = UIColor(named: "primaryText")
        l.font = UIFont.preferredFont(forTextStyle: .subheadline)
        l.numberOfLines = 0
        l.textAlignment = .right
        l.allowsDefaultTighteningForTruncation = true
        l.adjustsFontForContentSizeCategory = true
        return l
    }()
    
    var revenue: String? {
        didSet {
            revenueLabel.text = revenue
        }
    }
    
    var appName: String? {
        didSet {
            appNameLabel.text = appName
        }
    }
    
    var productIdentifier: String? {
        didSet {
            productIdentifierLabel.text = productIdentifier
        }
    }

    var purchaseTag: String? {
        didSet {
            tagLabel.text = purchaseTag
        }
    }
    
    var expiration: String? {
        didSet {
            expirationLabel.text = expiration
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.addSubview(container)
        container.addSubview(containerStackView)
        
        containerStackView.addArrangedSubview(leftStackView)
        containerStackView.addArrangedSubview(rightStackView)
        
        leftStackView.addArrangedSubview(appNameLabel)
        leftStackView.addArrangedSubview(productIdentifierLabel)
        
        rightStackView.addArrangedSubview(revenueLabel)
        rightStackView.addArrangedSubview(tagLabel)
        rightStackView.addArrangedSubview(expirationLabel)

        
        container.snp.makeConstraints { (make) in
            make.center.width.height.equalToSuperview()
        }
        
        containerStackView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalToSuperview().offset(-32)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

