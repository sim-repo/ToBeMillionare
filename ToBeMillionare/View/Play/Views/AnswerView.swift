//
//  AnswerView.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 06.06.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

class AnswerView: UIView {

    private var answerNum: Int = 0
    
    @IBInspectable var answerNumInspectable: Int {
           set { answerNum = newValue }
           get { return answerNum }
    }
    
    override func draw(_ rect: CGRect) {
        switch answerNum {
        case 0:
            TBMStyleKit.drawSymbolA(frame: bounds)
        case 1:
            TBMStyleKit.drawSymbolB(frame: bounds)
        case 2:
            TBMStyleKit.drawSymbolC(frame: bounds)
        case 3:
            TBMStyleKit.drawSymbolD(frame: bounds)
        default:
            TBMStyleKit.drawSymbolA(frame: bounds)
        }
    }
}
