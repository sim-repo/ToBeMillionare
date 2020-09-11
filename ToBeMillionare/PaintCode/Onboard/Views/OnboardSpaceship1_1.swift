//
//  OnboardInstruction.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 31.08.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

//#0005
class OnboardSpaceship1_1: UIView {
    
    var moveToOnboard: CGFloat = 0
    var onboardAnimation: CGFloat = 0.0
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    
    override func draw(_ rect: CGRect) {
        OnboardKit.drawOnboardSpaceship1(frame: bounds,
                                         resizing: .aspectFill,
                                         moveToOnboard: moveToOnboard,
                                         onboardAnimation: onboardAnimation,
                                         onboardOffset: 1)
    }
}


extension OnboardSpaceship1_1 {
    public func redrawMoveToOnboard(_ moveToOnboard: CGFloat) {
        self.moveToOnboard = moveToOnboard
        setNeedsDisplay()
    }
    
    public func redrawOnboardAnimation(_ onboardAnimation: CGFloat) {
        guard onboardAnimation < 0.82 else { return }
        
        self.onboardAnimation = onboardAnimation
        setNeedsDisplay()
    }
}
