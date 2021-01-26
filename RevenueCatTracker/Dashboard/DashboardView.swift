//
//  DashboardView.swift
//  RevenueCatTracker
//
//  Created by Joan Cardona on 24/1/21.
//

import Foundation
import UIKit

class DashboardView: UIView {
    let titleLabel: UILabel = {
        let l = UILabel()
        l.textColor = UIColor(named: "primaryText")
        l.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        l.numberOfLines = 0
        l.textAlignment = .natural
        l.text = "Dashboard"
        l.allowsDefaultTighteningForTruncation = true
        l.adjustsFontForContentSizeCategory = true
        return l
    }()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: {() -> UICollectionViewFlowLayout in
        let viewFlowLayout = UICollectionViewFlowLayout()
        viewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32)
        viewFlowLayout.minimumLineSpacing = 32
        viewFlowLayout.minimumInteritemSpacing = 0.0
        viewFlowLayout.scrollDirection = .vertical
        return viewFlowLayout
    }())
    
    init() {
        super.init(frame: .zero)
        addSubview(titleLabel)
        addSubview(collectionView)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-48)
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
