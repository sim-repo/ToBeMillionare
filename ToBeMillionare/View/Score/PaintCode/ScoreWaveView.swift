//
//  ScoreWaveView.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 06.06.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

class ScoreWaveView: UIView {
    

    // timer vars:
    private var globalTimer: Timer?
    private var timer: Timer?
    private var timeLeft = 60 // in ms
    private var halfTimeLeft = 30 // in ms
    private var globalTimerInterval = 10.0 // in sec
    
    // control vars:
    private var setOfPoints = 0
    private var step: CGFloat = 0.5
    
    
    private var outlineCtrlPoint0: CGFloat = 29.5
    private var outlineCtrlPoint1: CGFloat = 97.5
    private var outlineCtrlPoint2: CGFloat = 150.5
    private var outlineCtrlPoint3: CGFloat = 175.5
    private var outlineCtrlPoint4: CGFloat = 240.5
    private var outlineCtrlPoint5: CGFloat = 272
    private var outlineCtrlPoint6: CGFloat = 359
    
    private var fillCtrlPoint0: CGFloat = 28.5
    private var fillCtrlPoint1: CGFloat = 67.5
    private var fillCtrlPoint2: CGFloat = 116
    private var fillCtrlPoint3: CGFloat = 148
    private var fillCtrlPoint4: CGFloat = 211
    private var fillCtrlPoint5: CGFloat = 242.5
    private var fillCtrlPoint6: CGFloat = 338
    
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        TBMStyleKit.drawScoreWave(frame: bounds, resizing: .aspectFill)
        TBMStyleKit.drawScoreWave(frame: bounds,
                                  resizing: .aspectFill,
                                  outlineCtrlPoint0: outlineCtrlPoint0,
                                  outlineCtrlPoint1: outlineCtrlPoint1,
                                  outlineCtrlPoint2: outlineCtrlPoint2,
                                  outlineCtrlPoint3: outlineCtrlPoint3,
                                  outlineCtrlPoint4: outlineCtrlPoint4,
                                  outlineCtrlPoint5: outlineCtrlPoint5,
                                  outlineCtrlPoint6: outlineCtrlPoint6,
                                  fillCtrlPoint0: fillCtrlPoint0,
                                  fillCtrlPoint1: fillCtrlPoint1,
                                  fillCtrlPoint2: fillCtrlPoint2,
                                  fillCtrlPoint3: fillCtrlPoint3,
                                  fillCtrlPoint4: fillCtrlPoint4,
                                  fillCtrlPoint5: fillCtrlPoint5,
                                  fillCtrlPoint6: fillCtrlPoint6)
    }
    
    
    
    public func startAnimate() {
        setOfPoints = Int.random(in: 0 ... 4)
        resetTimer()
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.redraw), userInfo: nil, repeats: true)
        
        
        globalTimer = Timer.scheduledTimer(withTimeInterval: globalTimerInterval, repeats: true) {_ in
            self.setOfPoints = Int.random(in: 0 ... 4)
            self.resetTimer()
            self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.redraw), userInfo: nil, repeats: true)
        }
    }
    
    private func resetTimer(){
         timeLeft = 60
    }
    
    private func resetValues() {
        outlineCtrlPoint0 = 29.5
        outlineCtrlPoint1 = 97.5
        outlineCtrlPoint2 = 150.5
        outlineCtrlPoint3 = 175.5
        outlineCtrlPoint4 = 240.5
        outlineCtrlPoint5 = 272
        outlineCtrlPoint6 = 359
        
        fillCtrlPoint0 = 28.5
        fillCtrlPoint1 = 67.5
        fillCtrlPoint2 = 116
        fillCtrlPoint3 = 148
        fillCtrlPoint4 = 211
        fillCtrlPoint5 = 242.5
        fillCtrlPoint6 = 338
    }
    
    
    @objc private func redraw() {
  
        if halfTimeLeft... ~= timeLeft {
            step = abs(step)
        }
        
        if 0...halfTimeLeft-1 ~= timeLeft {
            step = -abs(step)
        }
        
        switch setOfPoints {
        case 0:
            outlineCtrlPoint0 += step
            outlineCtrlPoint1 -= step
            outlineCtrlPoint2 += step
            outlineCtrlPoint3 -= step
            outlineCtrlPoint4 += step
            outlineCtrlPoint5 -= step
            outlineCtrlPoint6 += step
            
            fillCtrlPoint0 += step
            fillCtrlPoint1 -= step
            fillCtrlPoint2 += step
            fillCtrlPoint3 -= step
            fillCtrlPoint4 += step
            fillCtrlPoint5 -= step
            fillCtrlPoint6 += step
        case 1:
            outlineCtrlPoint0 += step
            outlineCtrlPoint1 -= step
            outlineCtrlPoint2 += step
            outlineCtrlPoint3 -= step
            fillCtrlPoint0 += step
            fillCtrlPoint1 -= step
            fillCtrlPoint2 += step
            fillCtrlPoint3 -= step
        case 2:
            outlineCtrlPoint4 += step
            outlineCtrlPoint5 -= step
            outlineCtrlPoint6 += step
            fillCtrlPoint4 += step
            fillCtrlPoint5 -= step
            fillCtrlPoint6 += step
        case 3:
            outlineCtrlPoint4 += step
            outlineCtrlPoint5 -= step
            fillCtrlPoint4 += step
            fillCtrlPoint5 -= step
        case 4:
            outlineCtrlPoint0 += step
            outlineCtrlPoint1 -= step
            fillCtrlPoint0 += step
            fillCtrlPoint1 -= step
        default:
            break
        }
        
        setNeedsDisplay()
        
        timeLeft -= 1
        if timeLeft <= 0 {
            timer?.invalidate()
            resetValues()
        }
    }
    
}
