//
//  AskPeopleView.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 05.06.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit


class AuditoryHintIconView: UIView {
    
    // timer vars:
    private var timer: Timer?
    
    
    // control vars:
    private var scale: CGFloat = 1.0
    private var opacity: CGFloat = 1.0
    private var degree: Double = 0.0
    private var completion: (()->Void)? = nil
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        TBMStyleKit.drawAuditoryHintIcon(frame: bounds, resizing: .aspectFit, auditoryHintIconScale: scale, auditoryHintIconOpacity: opacity)
    }
    
    
    
    func startAnimate(completion: (()->Void)? = nil) {
        self.completion = completion
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawIcon), userInfo: nil, repeats: true)
    }
    
    
    private func getFraction() -> Double {
        return sin(degree * Double.pi / 180)
    }
    
    
    @objc private func redrawIcon(){
        
        if degree < 405 {
            degree += 2
        }
        scale = CGFloat(abs(getFraction()))
        
        
        if degree >= 405 {
            timer?.invalidate()
            opacity = 0.5
            completion?()
        }
        self.setNeedsDisplay()
    }
}
