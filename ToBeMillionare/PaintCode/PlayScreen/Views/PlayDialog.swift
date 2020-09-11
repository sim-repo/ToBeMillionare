//
//  PlayDialog.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 24.08.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

class PlayDialog: UIView {

    
    //redraw vars
    private var title: String = ""
    private var desc: String = ""
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        PlayScreenV2.drawDialog(frame: bounds, resizing: .aspectFit, dialogTitle: title, dialogDesc: desc)
    }
    
    
    public func setup(title: String, desc: String) {
        self.title = title
        self.desc = desc
        setNeedsDisplay()
    }
}


