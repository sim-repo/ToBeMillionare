//
//  OnboardInstruction.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 31.08.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

//#0005
class OnboardSpaceship3: UIView {
    
    var onboardAnimation: CGFloat = 0.0
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    
    override func draw(_ rect: CGRect) {
        OnboardKit.drawOnboardSpaceship3(frame: bounds,
                                         resizing: .aspectFill,
                                         onboardAnimation: onboardAnimation,
                                         onboardOffset: 1)
    }
}


extension OnboardSpaceship3 {
    
    public func redrawOnboardAnimation(_ onboardAnimation: CGFloat) {
        guard onboardAnimation > 1 else { return }
        self.onboardAnimation = onboardAnimation
        setNeedsDisplay()
    }
}

