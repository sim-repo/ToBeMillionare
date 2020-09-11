//
//  LogoDustLayer.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 04.08.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import Foundation


import UIKit


class LogoDustLayer: UIView {
    
    
    enum Direction {
        case plus, minus
    }
    
    // timer vars:
    private var timer: Timer?
    private var subTimer: Timer?
    
    private var firstTime: Bool = true
    
    // control vars:
    private var dustAnimation: CGFloat = 0.0
    
    private var direction: Direction = .plus
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        if ScreenResolutionsEnum.screen() == .screen_65 || ScreenResolutionsEnum.screen() == .screen_58 {
            LogoScreen.drawDust_65(frame: bounds, resizing: .center, dustAnimation: dustAnimation)
        } else if ScreenResolutionsEnum.screen() == .screen_55 {
            LogoScreen.drawDust_55(frame: bounds, resizing: .center, dustAnimation: dustAnimation)
        } else if ScreenResolutionsEnum.screen() == .screen_47 {
            LogoScreen.drawDust_47(frame: bounds, resizing: .center, dustAnimation: dustAnimation)
        }
    }
    
    
    private func runOnce(direction: inout Direction, current: inout CGFloat, step: CGFloat) {

        if direction == .plus {
            if current < 1.0 {
                current += step
            }
        } else {
            if current > 0.0 {
                current -= step
            }
        }
        
        self.setNeedsDisplay()
        
        if direction == .plus {
            if 1.0...1.0+step ~= current {
                direction = direction == .plus ? .minus : .plus
            }
        } else {
            if 0.0-step...0.0 ~= current {
                direction = direction == .plus ? .minus : .plus
            }
        }
    }
    
    
    public func stop() {
        timer?.invalidate()
        timer = nil
        subTimer?.invalidate()
        subTimer = nil
    }
    
    
    public func startAnimation() {
        startSubtimer()
    }
    
    
    private func startTimer() {
        guard firstTime else { return }
        firstTime = false
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(self.startSubtimer), userInfo: nil, repeats: true)
    }
    
    
    @objc private func startSubtimer(){
        subTimer?.invalidate()
        subTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.subRedraw), userInfo: nil, repeats: true)
    }
    
    
    @objc private func subRedraw(){
        runOnce(direction: &direction, current: &dustAnimation, step: 0.01)
    }
}



