//
//  SpaceshipEnvironment.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 10.07.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//


import UIKit



class SpaceshipEnvDiscreteAnimationLayer: UIView {
    
    // timer vars:
    private var timer1: Timer?
    private var timer2: Timer?
    
    
    // control vars:
    var discreteAnimation1: CGFloat = 0.0
    var smoothOnceAnimation: CGFloat = 0.0
    
    // repeating
    var discreteAnimationDirection1: Direction = .plus
    
    
    enum Direction {
        case plus, minus
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    
    public func stop() {
        timer1?.invalidate()
        timer1 = nil
        timer2?.invalidate()
        timer2 = nil
    }
    
    
    override func draw(_ rect: CGRect) {
        if ScreenResolutionsEnum.screen() == .screen_47 {
            SpaceshipEnvironmentScreen.drawSpaceshipDiscreteAnimationLayer_47(frame: bounds, discreteAnimation1: discreteAnimation1)
        } else {
            SpaceshipEnvironmentScreen.drawSpaceshipDiscreteAnimationLayer(frame: bounds, discreteAnimation1: discreteAnimation1)
        }
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
            if 1.0-step...1.0+step ~= current {
                timer.invalidate()
            }
        } else {
            if 0.0-step...0.0+step ~= current {
                timer.invalidate()
            }
        }
    }
    
    
    private func repeatingFraction(direction: inout Direction, fraction: inout CGFloat, step: CGFloat) {
        if direction == .plus {
            if fraction < 1.0 {
                fraction += step
            } else {
                direction = .minus
            }
        } else {
            if fraction > 0.0 {
                fraction -= step
            } else {
                direction = .plus
            }
        }
    }
    
    
    public func startAnimation() {
        timer1 = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawTimer1), userInfo: nil, repeats: true)
        timer2 = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.redrawTimer2), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawTimer1(){
        guard let timer = timer1 else { return }
        var currentSmoothAnimation1 = 0
        runOnce(timer: timer, direction: .plus, current: &smoothOnceAnimation, step: 0.04, nextAnimationNum: &currentSmoothAnimation1)
    }
    
    @objc private func redrawTimer2(){
        repeatingFraction(direction: &discreteAnimationDirection1, fraction: &discreteAnimation1, step: 0.1)
        setNeedsDisplay()
    }
}




