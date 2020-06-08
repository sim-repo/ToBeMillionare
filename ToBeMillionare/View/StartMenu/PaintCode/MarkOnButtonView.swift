//
//  MarkOnButtonView.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 04.06.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit


class MarkOnButtonView: UIView {

    private var markNumber: Int = 0
  
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    @IBInspectable var markNumberInspectable: Int {
        set { markNumber = newValue }
        get { return markNumber }
    }
    
    override func draw(_ rect: CGRect) {
        //backgroundColor = .brown
         switch markNumber {
               case 0:
                TBMStyleKit.drawPlay_markCanvas(frame: bounds)
               case 1:
                TBMStyleKit.drawLeaderboard_markCanvas(frame: bounds)
               case 2:
                TBMStyleKit.drawOptions_markCanvas(frame: bounds)
               default:
                TBMStyleKit.drawOptions_markCanvas(frame: bounds)
        }
    }
}
