//
//  AnswerView.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 06.06.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

class MoneyView2: UIView {
    
    private var levelEnum: LevelEnum = .level1
    
    // timer vars:
    private var timer: Timer?
    
    
    private var completion: (()->Void)?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    
    override func draw(_ rect: CGRect) {
        switch levelEnum {
        case .level1:
            TBMStyleKit.drawMoneyRound0(frame: bounds)
        case .level2:
            TBMStyleKit.drawMoneyRound1(frame: bounds)
        case .level3:
            TBMStyleKit.drawMoneyRound2(frame: bounds)
        case .level4:
            TBMStyleKit.drawMoneyRound3(frame: bounds)
        case .level5:
            TBMStyleKit.drawMoneyRound4(frame: bounds)
        case .level6:
            TBMStyleKit.drawMoneyRound5(frame: bounds)
        case .level7:
            TBMStyleKit.drawMoneyRound6(frame: bounds)
        case .level8:
            TBMStyleKit.drawMoneyRound7(frame: bounds)
        case .level9:
            TBMStyleKit.drawMoneyRound8(frame: bounds)
        case .level10:
            TBMStyleKit.drawMoneyRound9(frame: bounds)
        case .level11:
            TBMStyleKit.drawMoneyRound10(frame: bounds)
        case .level12:
            TBMStyleKit.drawMoneyRound11(frame: bounds)
        case .level13:
            TBMStyleKit.drawMoneyRound12(frame: bounds)
        }
    }
    
    
    func startAnimate(_ levelEnum: LevelEnum, _ completion: (()->Void)? = nil) {
        self.levelEnum = levelEnum
        setNeedsDisplay()
        self.completion = completion
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(self.startCompletion), userInfo: nil, repeats: false)
    }
    
    
    @objc private func startCompletion(){
        timer?.invalidate()
        completion?()
    }
}
