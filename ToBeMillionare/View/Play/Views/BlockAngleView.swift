//
//  AnswerView.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 06.06.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

class BlockView: UIView {

    private var blockNum: Int = 0
    
    required init?(coder: NSCoder) {
       super.init(coder: coder)
       backgroundColor = .clear
    }
       
    
    @IBInspectable var blockNumInspectable: Int {
           set { blockNum = newValue }
           get { return blockNum }
    }
    
    override func draw(_ rect: CGRect) {
        switch blockNum {
        case 0:
            TBMStyleKit.drawBlockLeftAngle(frame: bounds, resizing: .stretch)
        case 1:
            TBMStyleKit.drawBlockRightAngle(frame: bounds, resizing: .stretch)
        default:
            TBMStyleKit.drawBlockLeftAngle(frame: bounds, resizing: .stretch)
        }
    }
}
