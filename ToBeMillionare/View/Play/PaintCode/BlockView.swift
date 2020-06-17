//
//  AnswerView.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 06.06.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

class BlockView: UIView {
    
    // timer vars:
    private var timer: Timer?
    
    private var blockNum: Int = 0
    private var greenTint: CGFloat = 0.0
    private var redTint: CGFloat = 0.0
    private var yellowTint: CGFloat = 0.0
    private var curBlinkTry = 0
    
    private var targetTintColorEnum: TintColorEnum = .black
    
    private var completion: (()->Void)?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    
    @IBInspectable var blockNumInspectable: Int {
        set { blockNum = newValue }
        get { return blockNum }
    }
    
    
    enum TintColorEnum {
        case black, green, red, yellow
    }
    
    
    override func draw(_ rect: CGRect) {
        switch blockNum {
        case 0:
            TBMStyleKit.drawBlockLeftAngle(frame: bounds, resizing: .stretch, blockGreenTintColor: greenTint, blockRedTintColor: redTint, blockYellowTintColor: yellowTint)
        case 1:
            TBMStyleKit.drawBlockRightAngle(frame: bounds, resizing: .stretch, blockGreenTintColor: greenTint, blockRedTintColor: redTint, blockYellowTintColor: yellowTint)
        case 2:
            TBMStyleKit.drawCentralBlockCanvas(frame: bounds, resizing: .stretch, blockGreenTintColor: greenTint, blockRedTintColor: redTint, blockYellowTintColor: yellowTint)
        default:
            TBMStyleKit.drawBlockLeftAngle(frame: bounds, resizing: .stretch, blockGreenTintColor: greenTint, blockRedTintColor: redTint, blockYellowTintColor: yellowTint)
        }
    }
}


//MARK: - tint

extension BlockView {
    
    
    public func animateShowAnswer(tintColorEnum: TintColorEnum, completion: (()->Void)? = nil) {
        targetTintColorEnum = tintColorEnum
        
        greenTint = 0.0
        redTint = 0.0
        yellowTint = 0.0
        self.completion = completion
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawShowAnswerTint), userInfo: nil, repeats: true)
    }
    
    public func animateBlink(completion: (()->Void)? = nil) {
        targetTintColorEnum = .yellow
        
        greenTint = 0.0
        redTint = 0.0
        yellowTint = 0.0
        curBlinkTry = 0
        self.completion = completion
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawBlinkTint), userInfo: nil, repeats: true)
    }
    
    
    public func setBlackBackground() {
        greenTint = 0.0
        redTint = 0.0
        yellowTint = 0.0
        self.setNeedsDisplay()
    }
    
    
    @objc private func redrawShowAnswerTint(){
        
        if targetTintColorEnum == .red {
            redTint += 0.01
        }
        
        if targetTintColorEnum == .green {
            greenTint += 0.01
        }
        
        self.setNeedsDisplay()
        
        if  greenTint >= 1.0 ||  redTint >= 1.0 {
            timer?.invalidate()
            completion?()
        }
    }
    
    
    @objc private func redrawBlinkTint(){
        
        if curBlinkTry == 0 || curBlinkTry == 2 {
            showYellow()
        }
        
        if curBlinkTry == 1 || curBlinkTry == 3 {
            hideYellow()
        }
        
        self.setNeedsDisplay()
        
        if  curBlinkTry > 3{
            timer?.invalidate()
            completion?()
        }
    }
    
    
    @objc private func showYellow(){
        
        if yellowTint < 1.0 {
            yellowTint += 0.01
        }
        
        if  yellowTint >= 1.0 {
            curBlinkTry += 1
        }
    }
    
    
    @objc private func hideYellow(){
        
        if yellowTint > 0.0 {
            yellowTint -= 0.01
        }
        
        if  yellowTint <= 0.0 {
            curBlinkTry += 1
        }
    }
}
