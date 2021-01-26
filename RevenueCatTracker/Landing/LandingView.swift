//
//  LandingView.swift
//  RevenueCatTracker
//
//  Created by Joan Cardona on 26/1/21.
//

import Foundation
import UIKit

class LandingView: UIView {
    let iconImageView: UIImageView = {
        let i = UIImageView(image: UIImage(named: "cat"))
        i.contentMode = .scaleAspectFit
        return i
    }()
    
    init() {
        super.init(frame: .zero)
        addSubview(iconImageView)
        
        iconImageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.equalTo(300)
            make.width.equalTo(200)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
