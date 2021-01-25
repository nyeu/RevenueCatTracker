//
//  TransactionsView.swift
//  RevenueCatTracker
//
//  Created by Joan Cardona on 25/1/21.
//

import Foundation
import UIKit

class TransactionsView: UIView {
    private let titleLabel: UILabel = {
        let l = UILabel()
        l.textColor = UIColor(named: "primaryText")
        l.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        l.numberOfLines = 0
        l.textAlignment = .natural
        l.text = "Transactions"
        l.allowsDefaultTighteningForTruncation = true
        l.adjustsFontForContentSizeCategory = true
        return l
    }()
    
    private let sandboxStackView: UIStackView = {
        let s = UIStackView()
        s.axis = .vertical
        s.spacing = 8
        return s
    }()
    
    private let sandboxLabel: UILabel = {
        let l = UILabel()
        l.textColor = UIColor(named: "primaryText")
        l.font = UIFont.preferredFont(forTextStyle: .footnote)
        l.textAlignment = .natural
        l.text = "Sandbox"
        l.allowsDefaultTighteningForTruncation = true
        l.adjustsFontForContentSizeCategory = true
        return l
    }()
    
    let sandboxSwitch: UISwitch = {
        let s = UISwitch()
        s.isOn = false
        return s
    }()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: {() -> UICollectionViewFlowLayout in
        let viewFlowLayout = UICollectionViewFlowLayout()
        viewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        viewFlowLayout.minimumLineSpacing = 20
        viewFlowLayout.minimumInteritemSpacing = 10.0
        viewFlowLayout.scrollDirection = .vertical
        return viewFlowLayout
    }())
    
    init() {
        super.init(frame: .zero)
        addSubview(titleLabel)
        addSubview(sandboxStackView)
        addSubview(collectionView)
        
        sandboxStackView.addArrangedSubview(sandboxLabel)
        sandboxStackView.addArrangedSubview(sandboxSwitch)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(24)
        }
        
        sandboxStackView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-24)
            make.centerY.equalTo(titleLabel)
            make.left.equalTo(titleLabel.snp.right).offset(24)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(32)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
