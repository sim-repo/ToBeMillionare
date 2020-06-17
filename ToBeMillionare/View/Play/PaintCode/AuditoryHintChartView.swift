//
//  AnswerView.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 06.06.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

class AuditoryHintChartView: UIView {
    
    
    // timer vars:
    private var timer: Timer?
    
    // control vars:
    private var columnMaxHeight: CGFloat = 300
    private var targetPercentColA: CGFloat = 0
    private var targetPercentColB: CGFloat = 0
    private var targetPercentColC: CGFloat = 0
    private var targetPercentColD: CGFloat = 0
    
    
    private var curPercentColA: CGFloat = 0
    private var curPercentColB: CGFloat = 0
    private var curPercentColC: CGFloat = 0
    private var curPercentColD: CGFloat = 0
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    
    override func draw(_ rect: CGRect) {
        
        
        TBMStyleKit.drawAuditoryHint(frame: bounds,
                                     resizing: .stretch,
                                     auditoryChartMaxHeight: columnMaxHeight,
                                     auditoryFractionA: curPercentColA,
                                     auditoryFractionB: curPercentColB,
                                     auditoryFractionC: curPercentColC,
                                     auditoryFractionD: curPercentColD)
    }
    
    
    func startAnimate(fractionPercentA: CGFloat, fractionPercentB: CGFloat, fractionPercentC: CGFloat, fractionPercentD: CGFloat) {
        
        curPercentColA = 0
        curPercentColB = 0
        curPercentColC = 0
        curPercentColD = 0
        
        self.targetPercentColA = fractionPercentA
        self.targetPercentColB = fractionPercentB
        self.targetPercentColC = fractionPercentC
        self.targetPercentColD = fractionPercentD
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(self.redrawPercents), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawPercents(){
        
        if curPercentColA < targetPercentColA {
            curPercentColA += 0.01
        }
        
        if curPercentColB < targetPercentColB {
            curPercentColB += 0.01
        }
        
        if curPercentColC < targetPercentColC {
            curPercentColC += 0.01
        }
        
        if curPercentColD < targetPercentColD {
            curPercentColD += 0.01
        }
        
        self.setNeedsDisplay()
        
        if curPercentColA >= targetPercentColA &&
           curPercentColB >= targetPercentColB &&
           curPercentColC >= targetPercentColC &&
           curPercentColD >= targetPercentColD {
            timer?.invalidate()
        }
    }
}
