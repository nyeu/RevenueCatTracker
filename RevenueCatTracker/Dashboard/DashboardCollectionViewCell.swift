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
        v.layer.cornerRadius = 75.0
        v.layer.masksToBounds = true
        v.layer.borderWidth = 10.0
        v.layer.borderColor = UIColor(named: "Navy")?.cgColor
        return v
    }()
    
    let labelsContainer: UIView = {
        let v = UIView()
        return v
    }()
    
    private lazy var valueLabel: UILabel = {
        let l = UILabel()
        l.textColor = UIColor(named: "primary")
        l.font = UIFont.preferredFont(forTextStyle: .title1).bold()
        l.numberOfLines = 1
        l.textAlignment = .center
        l.allowsDefaultTighteningForTruncation = true
        l.adjustsFontForContentSizeCategory = true
        l.minimumScaleFactor = (11.0 / UIFont.preferredFont(forTextStyle: .title1).bold().pointSize)
        l.adjustsFontSizeToFitWidth = true
        return l
    }()
    
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.textColor = UIColor(named: "primaryText")
        l.font = UIFont.preferredFont(forTextStyle: .headline)
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
        container.addSubview(labelsContainer)
        labelsContainer.addSubview(valueLabel)
        labelsContainer.addSubview(titleLabel)
        
        container.snp.makeConstraints { (make) in
            make.center.width.height.equalToSuperview()
        }
        
        labelsContainer.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.width.lessThanOrEqualToSuperview()
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
