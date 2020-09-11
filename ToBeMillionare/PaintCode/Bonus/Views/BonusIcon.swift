//
//  LogoDustLayer.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 04.08.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit


class BonusIcon: UIView {
    
    // timer vars:
    private var timer: Timer?
    private var subtimer: Timer?
    
    // redraw vars:
    private var move: CGFloat = 0.0
    private var blink: CGFloat = 0.0
   
    // ready vars
    private var isReadyForPress: Bool = true
    private var isReadyBlink: Bool = true
    
    
    private var completion: (()->Void)? = nil
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        BonusKit.drawBonusIcon(frame: bounds, resizing: .aspectFit, miniStarMove: move, miniStarBlink: blink)
    }
    
    public func stop() {
        subtimer?.invalidate()
        timer?.invalidate()
    }
}



// MARK:- Press
extension BonusIcon {
    
    public func didPress(completion: (()->Void)? ) {
        guard isReadyForPress else { return }
        isReadyForPress = false
        stop()
        self.completion = completion
        startPressAnimation()
    }

    private func startPressAnimation() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval:0.004, target: self, selector: #selector(self.redrawPress), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawPress(){
        runOnce(current: &move, step: 0.004)
    }
    
    private func runOnce(current: inout CGFloat, step: CGFloat) {
        if current < 1.0 {
            current += step
        }
        setNeedsDisplay()
    
        if 1.0...1.0+step ~= current {
            current = 1.0
            timer?.invalidate()
            completion?()
        }
    }
}



// MARK:- Blink
extension BonusIcon {
    
    public func tryBlink(hasBonus: Bool){
        
        guard isReadyBlink else { return }
        isReadyBlink = false
        
        move = hasBonus ? 0.01 : 0
        setNeedsDisplay()
        if hasBonus {
            startBlink()
        }
    }
    
    private func restartBlink() {
        subtimer?.invalidate()
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.startBlink), userInfo: nil, repeats: true)
    }
    
    @objc private func startBlink() {
       blink = 0
       subtimer?.invalidate()
       subtimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(self.redrawBlink), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawBlink(){
        checkPeriodicity(current: &blink, step: 0.02)
    }
    
    private func checkPeriodicity(current: inout CGFloat, step: CGFloat) {
        current += step
        setNeedsDisplay()
        if 1...1+step ~= current {
            current = 1
            setNeedsDisplay()
            restartBlink()
        }
    }
}

