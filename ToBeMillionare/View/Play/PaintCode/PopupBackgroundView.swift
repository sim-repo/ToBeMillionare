//
//  AnswerView.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 06.06.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

class PopupBackgroundView: UIView {

    
    required init?(coder: NSCoder) {
       super.init(coder: coder)
       backgroundColor = .clear
    }
    
    
    override func draw(_ rect: CGRect) {
        TBMStyleKit.drawCallHint(frame: bounds, resizing: .stretch)
    }
}
