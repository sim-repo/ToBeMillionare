//
//  PlayDialogButton.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 24.08.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

class PlayDialogButton: UIView {

    //redraw vars
    private var title: String = ""

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        PlayScreenV2.drawDialogButton(frame: bounds, resizing: .aspectFit, dialogButtonTitle: title)
    }
    
    
    public func setup(title: String) {
        self.title = title
        setNeedsDisplay()
    }
}



