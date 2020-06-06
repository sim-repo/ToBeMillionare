//
//  AnswerView.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 06.06.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

class MoneyView: UIView {

    private var roundNum: Int = 0
    
    required init?(coder: NSCoder) {
       super.init(coder: coder)
       backgroundColor = .clear
    }
       
    
    @IBInspectable var roundNumInspectable: Int {
           set { roundNum = newValue }
           get { return roundNum }
    }
    
    override func draw(_ rect: CGRect) {
        switch roundNum {
        case 1:
            TBMStyleKit.drawMoneyRound1(frame: bounds)
        case 2:
            TBMStyleKit.drawMoneyRound2(frame: bounds)
        case 3:
            TBMStyleKit.drawMoneyRound3(frame: bounds)
        case 4:
            TBMStyleKit.drawMoneyRound4(frame: bounds)
        case 5:
            TBMStyleKit.drawMoneyRound5(frame: bounds)
        case 6:
            TBMStyleKit.drawMoneyRound6(frame: bounds)
        case 7:
            TBMStyleKit.drawMoneyRound7(frame: bounds)
        case 8:
            TBMStyleKit.drawMoneyRound8(frame: bounds)
        case 9:
            TBMStyleKit.drawMoneyRound9(frame: bounds)
        case 10:
            TBMStyleKit.drawMoneyRound10(frame: bounds)
        case 11:
            TBMStyleKit.drawMoneyRound11(frame: bounds)
        case 12:
            TBMStyleKit.drawMoneyRound12(frame: bounds)
        case 13:
            TBMStyleKit.drawMoneyRound13(frame: bounds)
        default:
            TBMStyleKit.drawMoneyRound1(frame: bounds)
        }
    }
}
