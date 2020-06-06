//
//  RoundedView.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 04.06.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//


import UIKit

class RoundShadowView: UIView {
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutView()
    }

    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        layoutView()
    }

    
    func layoutView() {
      backgroundColor = TBMStyleKit.mainBackground
      layer.shadowOpacity = 1
      layer.shadowOffset = CGSize(width: 0, height: 0)
      layer.shadowRadius = 4
      layer.shouldRasterize = true
      layer.shadowColor = UIColor.black.cgColor
      layer.cornerRadius = layer.bounds.width/2
        
      let gradientLayer = CAGradientLayer()
      gradientLayer.frame = bounds
      gradientLayer.colors = [#colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1).cgColor, #colorLiteral(red: 0, green: 0.6242693067, blue: 0.701328218, alpha: 1).cgColor]
      gradientLayer.cornerRadius = layer.bounds.width/2
      layer.addSublayer(gradientLayer)
    }
}
