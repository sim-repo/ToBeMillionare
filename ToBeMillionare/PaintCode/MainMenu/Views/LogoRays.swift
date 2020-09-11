//
//  LogoDustLayer.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 04.08.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import Foundation


import UIKit


class LogoRaysLayer: UIView {
    
    enum Direction {
        case plus, minus
    }
    
    // timer vars:
    private var subTimer: Timer?
    
    private var firstTime: Bool = true
    
    // control vars:
    private var rayAnimation: CGFloat = 0.0
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        if ScreenResolutionsEnum.screen() == .screen_65 || ScreenResolutionsEnum.screen() == .screen_58 {
            LogoScreen.drawRays_65(frame: bounds, resizing: .center, rayAnimation: rayAnimation, zigzag2PinkOffset: 0.45)
        } else if ScreenResolutionsEnum.screen() == .screen_55 {
            LogoScreen.drawRays_55(frame: bounds, resizing: .center, rayAnimation: rayAnimation, zigzag2PinkOffset: 0.45)
        } else if ScreenResolutionsEnum.screen() == .screen_47 {
            LogoScreen.drawRays_47(frame: bounds, resizing: .center, rayAnimation: rayAnimation, zigzag2PinkOffset: 0.45)
        }
    }
    
    public func stop() {
        subTimer?.invalidate()
        subTimer = nil
    }
    
    
    private func runOnce(current: inout CGFloat, step: CGFloat, target: CGFloat) {

        if current <= target {
            current += step
        }
        
        self.setNeedsDisplay()
        
        if target...target+step ~= current {
            current = 0
        }
    }
    
    
    public func startAnimation() {
        startSubtimer()
    }
    
    @objc private func startSubtimer(){
        subTimer?.invalidate()
        subTimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(self.subRedraw), userInfo: nil, repeats: true)
    }
    
  //  0.0002
    @objc private func subRedraw(){
        runOnce(current: &rayAnimation, step: 0.0006, target: 0.3)
    }
}
//0.0002*x = 0.02
//x = 100

