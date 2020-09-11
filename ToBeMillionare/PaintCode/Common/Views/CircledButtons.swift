//
//  CircledButtons.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 23.07.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit


class CircledButton: UIView {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        CommonKit.drawCircledButtonView(frame: bounds, resizing: .aspectFit)
    }
}


// Holo
class HoloCircledButton: UIView {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        CommonKit.drawHoloCircledButtonView(frame: bounds, resizing: .aspectFit)
    }
}
