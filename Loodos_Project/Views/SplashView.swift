//
//  SplashView.swift
//  Loodos_Project
//
//  Created by Ünal Öztürk on 4.02.2019.
//  Copyright © 2019 Ünal Öztürk. All rights reserved.
//

import UIKit

class SplashView: UIView {
    
    var loodosLabel: UILabel = {
        var lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor(named: ColorsSet.appColor )
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
        
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        editUI()
    }
    
    func editUI() {
        backgroundColor = .white
        addSubview(loodosLabel)
        [
            loodosLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            loodosLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            loodosLabel.heightAnchor.constraint(equalToConstant: 50),
            loodosLabel.widthAnchor.constraint(equalToConstant: 100),
        ].forEach { $0.isActive = true }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
