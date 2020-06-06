//
//  AskPeopleView.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 05.06.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit


class FiftyPercentView: UIView {

     required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        TBMStyleKit.drawFiftyPercent(frame: bounds, resizing: .aspectFit)
    }

}
