//
//  TopView.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 04.06.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit


class TopView: UIView {

     required init?(coder: NSCoder) {
        super.init(coder: coder)
       // backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        TBMStyleKit.drawTopCanvas(frame: bounds, resizing: .stretch)
    }

}
