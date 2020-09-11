//
//  OnboardHolo.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 31.08.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

//#0005
class OnboardHolo: UIView {
    
    
    // timer vars:
    private var timer: Timer?
    
    // redraw vars:
    var moveToOnboard: CGFloat = 0.0
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        OnboardKit.drawOnboardHoloView(frame: bounds, resizing: .aspectFill, moveToOnboard: moveToOnboard)
    }
    
    
    
    private func checkPhase(current: inout CGFloat, target: CGFloat, step: CGFloat) {
        if current < target {
            current += step
        }
        setNeedsDisplay()
        if target...target+step ~= current {
            current = target
            setNeedsDisplay()
            timer?.invalidate()
        }
    }
    
    
    public func startAnimation() {
        startPhase1()
    }
    
    private func startPhase1() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase1), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase1(){
        checkPhase(current: &moveToOnboard, target: 1, step: 0.01)
    }
}
