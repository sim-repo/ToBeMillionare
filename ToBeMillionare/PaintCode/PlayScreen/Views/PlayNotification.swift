//
//  PlayNotification.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 25.08.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

class PlayNotification: UIView {

    //redraw vars
    private var text: String = ""

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        PlayScreenV2.drawNotification(frame: bounds, resizing: .aspectFit, dialogTitle: text)
    }
    
    
    public func setup(text: String) {
        self.text = text
        setNeedsDisplay()
    }
}


