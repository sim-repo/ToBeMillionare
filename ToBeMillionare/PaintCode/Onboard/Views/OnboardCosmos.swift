//
//  OnboardInstruction.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 31.08.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

//#0005
class OnboardCosmos: UIView {
    
    var moveToOnboard: CGFloat = 0
    var onboardAnimation: CGFloat = 0.0
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    
    override func draw(_ rect: CGRect) {
        OnboardKit.drawOnboardCosmos(frame: bounds,
                                     resizing: .aspectFit,
                                     moveToOnboard: moveToOnboard,
                                     onboardAnimation: onboardAnimation,
                                     onboardOffset: 1)
    }
}
 

extension OnboardCosmos {
    public func redrawMoveToOnboard(_ moveToOnboard: CGFloat) {
        self.moveToOnboard = moveToOnboard
        setNeedsDisplay()
    }
    
    public func redrawOnboardAnimation(_ onboardAnimation: CGFloat) {
        guard onboardAnimation < 0.1 || onboardAnimation >= 1.21 else { return }
        self.onboardAnimation = onboardAnimation
        setNeedsDisplay()
    }
}
