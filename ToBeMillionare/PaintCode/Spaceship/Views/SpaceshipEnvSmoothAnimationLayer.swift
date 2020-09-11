//
//  SpaceshipEnvironment.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 10.07.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//


import UIKit


class SpaceshipEnvSmoothAnimationLayer: UIView {
    
    // timer vars:
    private var timer: Timer?
    private var subTimer: Timer?
    
    
    private var currentSmoothAnimation = 0
    
    // control vars:
    var smoothAnimation1: CGFloat = 0.0
    var smoothAnimation2: CGFloat = 0.0
    var smoothAnimation3: CGFloat = 0.0
    
    var smoothAnimationDirection1: Direction = .plus
    var smoothAnimationDirection2: Direction = .plus
    var smoothAnimationDirection3: Direction = .plus
    
    
    enum Direction {
        case plus, minus
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    
    override func draw(_ rect: CGRect) {
        
        SpaceshipEnvironmentScreen.drawSpaceshipSmoothAnimationLayer(frame: bounds,
                                                                     smoothAnimation1: smoothAnimation1,
                                                                     smoothAnimation2: smoothAnimation2,
                                                                     zigzag2PinkOffset: 0.3,
                                                                     tubeOvalOffset: 0.25,
                                                                     starBlink: smoothAnimation3)
    }
    
    
    public func stop() {
        timer?.invalidate()
        timer = nil
        subTimer?.invalidate()
        subTimer = nil
    }
    
    
    private func runOnce(timer: Timer, direction: Direction = .plus, current: inout CGFloat, step: CGFloat, nextAnimationNum: inout Int) {
        
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
                subTimer?.invalidate()
            }
        } else {
            if 0.0-step...0.0 ~= current {
                subTimer?.invalidate()
            }
        }
    }
    
    
    public func startAnimation() {
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.redrawTimer), userInfo: nil, repeats: true)
    }
    
    
    
    @objc private func redrawTimer(){
        
        if currentSmoothAnimation >= 2 {
            currentSmoothAnimation = 0
        } else {
            currentSmoothAnimation += 1
        }
        
        subTimer?.invalidate()
        
        switch currentSmoothAnimation {
        case 0:
            smoothAnimationDirection1 = smoothAnimationDirection1 == .plus ? .minus : .plus
            smoothAnimation1 = smoothAnimationDirection1 == .plus ? 0 : 1
        case 1:
            smoothAnimationDirection2 = smoothAnimationDirection2 == .plus ? .minus : .plus
            smoothAnimation2 = smoothAnimationDirection2 == .plus ? 0 : 1
        case 2:
            smoothAnimationDirection3 = smoothAnimationDirection3 == .plus ? .minus : .plus
            smoothAnimation3 = smoothAnimationDirection3 == .plus ? 0 : 1
        default:
            break
        }
        subTimer = Timer.scheduledTimer(timeInterval: 0.04, target: self, selector: #selector(self.subRedrawTimer), userInfo: nil, repeats: true)
    }
    
    
    @objc private func subRedrawTimer(){
        guard let timer = subTimer else { return }
        switch currentSmoothAnimation {
        case 0:
            runOnce(timer: timer, direction: smoothAnimationDirection1, current: &smoothAnimation1, step: 0.01, nextAnimationNum: &currentSmoothAnimation)
        case 1:
            runOnce(timer: timer, direction: smoothAnimationDirection2, current: &smoothAnimation2, step: 0.01, nextAnimationNum: &currentSmoothAnimation)
        case 2:
            runOnce(timer: timer, direction: smoothAnimationDirection3, current: &smoothAnimation3, step: 0.01, nextAnimationNum: &currentSmoothAnimation)
        default:
            break
        }
    }
}




