//
//  StageBkg.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 02.08.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit


class StageBkg: UIView {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        NextStageKit.drawBkg(frame: bounds)
    }
}

