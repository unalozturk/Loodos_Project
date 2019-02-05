//
//  MoviesDetailView.swift
//  Loodos_Project
//
//  Created by Ünal Öztürk on 4.02.2019.
//  Copyright © 2019 Ünal Öztürk. All rights reserved.
//

import UIKit
import Kingfisher

class MoviesDetailView: UIView {
    
    var posterImageWidthAnchor: NSLayoutConstraint?
    var posterImageHeightAnchor: NSLayoutConstraint?
    
    var posterImage: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.kf.indicatorType = .activity
        return imageView
    }()
    
    var movieNameLbl : UILabel =  {
        var lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.textColor =  UIColor(named: ColorsSet.appColor )
        return lbl
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        editUI()
    }
    
    func editUI()    {
        backgroundColor = .purple
        
        screenRotated()
        
        addSubview(posterImage)
        [
            posterImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            posterImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            posterImageHeightAnchor!,
            posterImageWidthAnchor!,
        ].forEach { $0.isActive = true }
        
 
        addSubview(movieNameLbl)
        [
            movieNameLbl.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 10),
            movieNameLbl.heightAnchor.constraint(equalToConstant: 100),
            movieNameLbl.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieNameLbl.trailingAnchor.constraint(equalTo: trailingAnchor),
        ].forEach { $0.isActive = true }
    }
    
    func screenRotated() {
        let orientation = UIDevice.current.orientation
        
        posterImageHeightAnchor?.isActive = false;
        posterImageWidthAnchor?.isActive = false;
        
        
        if orientation == .portrait {
            let size = UIScreen.main.bounds.width
            posterImageWidthAnchor = posterImage.widthAnchor.constraint(equalToConstant:size  )
            posterImageHeightAnchor = posterImage.heightAnchor.constraint(equalToConstant:size  )
        }
        else {
            let size = UIScreen.main.bounds.height
            posterImageWidthAnchor = posterImage.widthAnchor.constraint(equalToConstant: size / 2)
            posterImageHeightAnchor = posterImage.heightAnchor.constraint(equalToConstant: size / 2 )
            
        }
        
        posterImageHeightAnchor?.isActive = true;
        posterImageWidthAnchor?.isActive = true;
        
        layoutIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
