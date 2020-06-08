//
//  HoneycombView.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 04.06.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit


class HoneycombView: UIView {
    
    private var honeycomNumber: Int = 0
    
    @IBInspectable var honeycomNumberInspectable: Int {
        set { honeycomNumber = newValue }
        get { return honeycomNumber }
    }
    
    
    override func draw(_ rect: CGRect) {
        switch honeycomNumber {
        case 0:
            TBMStyleKit.drawPlay_HoneycombsCanvas(frame: bounds)
        case 1:
            TBMStyleKit.drawLeaderboard_HoneycombsCanvas(frame: bounds)
        default:
            TBMStyleKit.drawPlay_HoneycombsCanvas(frame: bounds)
        }
    }
}
