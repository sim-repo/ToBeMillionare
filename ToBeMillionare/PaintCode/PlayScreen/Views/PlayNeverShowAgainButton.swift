//
//  PlayNeverShowAgainButton.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 25.08.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

class PlayNeverShowAgainButton: UIView {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        PlayScreenV2.drawNeverShowAgainButton(frame: bounds, resizing: .aspectFit)
    }

}

