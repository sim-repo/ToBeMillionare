//
//  ProfileBkg.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 29.08.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

// #0004
class ProfileBkg: UIView {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        AvaKit.drawBkg(frame: bounds, resizing: .aspectFit)
    }
}

