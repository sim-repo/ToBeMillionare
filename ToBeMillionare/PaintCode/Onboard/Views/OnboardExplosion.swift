//
//  OnboardExplosion.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 04.09.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

//#0005
class OnboardExplosion: UIView {
    
    var onboardAnimation: CGFloat = 0.0
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    
    override func draw(_ rect: CGRect) {
        OnboardKit.drawOnboardExplosion(frame: bounds, resizing: .aspectFill, onboardAnimation: onboardAnimation)
    }
}
 

extension OnboardExplosion {

    public func redrawOnboardAnimation(_ onboardAnimation: CGFloat) {
        guard onboardAnimation >= 0.8 && onboardAnimation < 1.1 else { return }
        self.onboardAnimation = onboardAnimation
        print(onboardAnimation)
        setNeedsDisplay()
    }
}

