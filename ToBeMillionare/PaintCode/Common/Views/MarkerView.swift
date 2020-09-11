//
//  SpaceshipEnvironment.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 10.07.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//


import UIKit


class MarkerView: UIView {
    
    // timer vars:
    private var timer: Timer?
    private var subtimer: Timer?
    private var delayBlink: TimeInterval?
    
    
    // redraw vars:
    private var fraction: CGFloat = 0.0
    private var smoothAnimationDirection: Direction = .plus
    private var buttonType: ButtonType = .red
    
    enum ButtonType {
        case red, green, blue, yellow
    }
    
    enum Direction {
        case plus, minus
    }
    
    // ready vars
    private var isReadyForPress: Bool = true
    private var isReadyBlink: Bool = true
    

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        switch buttonType {
        case .red:
            CommonKit.drawRedButton(frame: bounds,
                                      resizing: .aspectFit,
                                      fraction: fraction)
        case .green:
            CommonKit.drawGreenButton(frame: bounds,
                                      resizing: .aspectFit,
                                      fraction: fraction)
        case .blue:
            CommonKit.drawBlueButton(frame: bounds,
                                     resizing: .aspectFit,
                                     fraction: fraction)
        case .yellow:
            CommonKit.drawYellowButton(frame: bounds,
                                     resizing: .aspectFit,
                                     fraction: fraction)
        }
    }
    
    public func stop() {
        subtimer?.invalidate()
        timer?.invalidate()
        
    }
}


// MARK:- Press
extension MarkerView {
    
    public func didPress(type: ButtonType) {
        guard isReadyForPress else { return }
        isReadyForPress = false
        
        stop()
        self.buttonType = type
        fraction = 0
        subtimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPress), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPress(){
        guard let timer = subtimer else { return }
        smoothAnimationDirection = .plus
        runOnce(timer: timer, direction: smoothAnimationDirection, current: &fraction, step: 0.005)
    }
    
    private func runOnce(timer: Timer, direction: Direction = .plus, current: inout CGFloat, step: CGFloat) {
        
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
                timer.invalidate()
                isReadyForPress = true
            }
        } else {
            if 0.0-step...0.0 ~= current {
                timer.invalidate()
                isReadyForPress = true
            }
        }
    }
}



// MARK:- Blink
extension MarkerView {
    
    public func prepareBlink() {
        isReadyBlink = true
    }
    
    public func tryBlink(type: ButtonType, delayBlink: TimeInterval? = nil){
        guard isReadyBlink else { return }
        isReadyBlink = false
        
        self.delayBlink = delayBlink
        buttonType = type
        setNeedsDisplay()
        startBlink()
    }
    
    @objc private func startBlink() {
       subtimer?.invalidate()
       smoothAnimationDirection = smoothAnimationDirection == .plus ? .minus : .plus
       subtimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawBlink), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawBlink() {
        checkPeriodicity(direction: smoothAnimationDirection, current: &fraction, step: 0.002)
    }
    
    
    private func restartBlink() {
        subtimer?.invalidate()
        timer?.invalidate()
        let delay: TimeInterval = delayBlink ?? 5.0
        timer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(self.startBlink), userInfo: nil, repeats: true)
    }
    
    
    private func checkPeriodicity(direction: Direction = .plus, current: inout CGFloat, step: CGFloat) {

        if direction == .plus {
            if current < 1 {
                current += step
            }
        } else {
            if current > 0 {
                current -= step
            }
        }
        
        setNeedsDisplay()
        
        if direction == .plus {
            if 1...1+step ~= current {
                current = 1
                setNeedsDisplay()
                restartBlink()
            }
        } else {
            if 0-step...0 ~= current {
                current = 0
                setNeedsDisplay()
                restartBlink()
            }
        }
    }
}

