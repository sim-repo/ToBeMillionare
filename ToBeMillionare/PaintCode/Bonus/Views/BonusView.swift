//
//  LogoDustLayer.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 04.08.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import Foundation


import UIKit


class BonusView: UIView {
    
    // timer vars:
    private var timer: Timer?

    // control vars:
    private var move: CGFloat = 0.0
    private var bonusText: String = ""
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
         BonusKit.drawBonus(frame: bounds, resizing: .aspectFit, move: move, bonusText: bonusText)
    }
    
    
    private func runOnce(current: inout CGFloat, step: CGFloat) {

        if current < 1.0 {
            current += step
        }
        
        self.setNeedsDisplay()
        
        if 1.0...1.0+step ~= current {
            current = 1.0
            timer?.invalidate()
            timer = nil
        }
    }
    
    
    public func stop() {
        timer?.invalidate()
        timer = nil
        move = 0
    }
    
    
    public func startAnimation(_ text: String) -> Bool{
        guard timer == nil else { return false }
        move = 0
        self.bonusText = text
        startTimer()
        return true
    }
    
    
    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval:0.003, target: self, selector: #selector(self.subRedraw), userInfo: nil, repeats: true)
    }
    
    
    @objc private func subRedraw(){
        runOnce(current: &move, step: 0.001)
    }
}



