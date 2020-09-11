//
//  OnboardInstruction.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 31.08.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

//#0005
class OnboardMeteorit: UIView {

    var onboardAnimation: CGFloat = 0.0
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    
    override func draw(_ rect: CGRect) {
        OnboardKit.drawOnboardMeteoritView(frame: bounds,
                                           resizing: .aspectFit,
                                           onboardAnimation: onboardAnimation)
    }
}
 

extension OnboardMeteorit {
    
    public func redrawOnboardAnimation(_ onboardAnimation: CGFloat) {
        self.onboardAnimation = onboardAnimation
        setNeedsDisplay()
    }
}
