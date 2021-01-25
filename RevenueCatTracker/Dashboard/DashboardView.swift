//
//  DashboardView.swift
//  RevenueCatTracker
//
//  Created by Joan Cardona on 24/1/21.
//

import Foundation
import UIKit

class DashboardView: UIView {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: {() -> UICollectionViewFlowLayout in
        let viewFlowLayout = UICollectionViewFlowLayout()
        viewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        viewFlowLayout.minimumLineSpacing = 10
        viewFlowLayout.minimumInteritemSpacing = 0.0
        viewFlowLayout.scrollDirection = .horizontal
        return viewFlowLayout
    }())
    
    init() {
        super.init(frame: .zero)
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
