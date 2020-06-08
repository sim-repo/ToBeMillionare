//
//  LogoView.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 04.06.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit


class LogoView: UIView {

     override func draw(_ rect: CGRect) {
        TBMStyleKit.drawLogo(frame: bounds)
    }
}
