//
//  TransactionsView.swift
//  RevenueCatTracker
//
//  Created by Joan Cardona on 25/1/21.
//

import Foundation
import UIKit
import PickerButton

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
    
    private let topButtonsStackView: UIStackView = {
        let s = UIStackView()
        s.axis = .horizontal
        s.spacing = 16
        s.distribution = .fillEqually
        return s
    }()
    
    var filterButton: PickerButton = {
        let b = PickerButton()
        b.setTitle("Filter", for: .normal)
        b.setImage(UIImage(named: ""), for: .normal)
        b.layer.cornerRadius = 15.0
        b.layer.borderWidth = 2.0
        b.layer.borderColor = UIColor(named: "Navy")?.cgColor
        b.isEnabled = false
        b.setTitleColor(UIColor(named: "primaryText"), for: .normal)
        return b
    }()
    
    let searchButton: UIButton = {
        let b = UIButton()
        b.setTitle("Search", for: .normal)
        b.setImage(UIImage(named: "magnifyingglass"), for: .normal)
        b.layer.cornerRadius = 15.0
        b.layer.borderWidth = 2.0
        b.layer.borderColor = UIColor(named: "Navy")?.cgColor
        b.isEnabled = false
        b.setTitleColor(UIColor(named: "primaryText"), for: .normal)
        return b
    }()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: {() -> UICollectionViewFlowLayout in
        let viewFlowLayout = UICollectionViewFlowLayout()
        viewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        viewFlowLayout.minimumLineSpacing = 20
        viewFlowLayout.minimumInteritemSpacing = 10.0
        viewFlowLayout.scrollDirection = .vertical
        return viewFlowLayout
    }())
    
    init() {
        super.init(frame: .zero)
        addSubview(titleLabel)
        addSubview(sandboxStackView)
        addSubview(topButtonsStackView)
        addSubview(collectionView)
        
        sandboxStackView.addArrangedSubview(sandboxLabel)
        sandboxStackView.addArrangedSubview(sandboxSwitch)
        
        topButtonsStackView.addArrangedSubview(filterButton)
        topButtonsStackView.addArrangedSubview(searchButton)
        
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(24)
        }
        
        sandboxStackView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-24)
            make.centerY.equalTo(titleLabel)
            make.left.equalTo(titleLabel.snp.right).offset(24)
        }
        
        topButtonsStackView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(32)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(40)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(topButtonsStackView.snp.bottom).offset(32)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
