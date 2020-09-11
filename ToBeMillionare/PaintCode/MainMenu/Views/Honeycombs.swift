//
//  Honeycombs.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 05.08.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

class Honeycombs: UIView {
    
    enum HoneycombsEnum {
        case one, two
    }
    
    private var honeycombsEnum: HoneycombsEnum = .one
    
    override func draw(_ rect: CGRect) {
        switch honeycombsEnum {
        case .one:
            LogoScreen.drawHoneycombs1(frame: bounds, resizing: .aspectFit)
        case .two:
            LogoScreen.drawHoneycombs2(frame: bounds, resizing: .aspectFit)
        }
    }
    
    public func setup(_ honeycombsEnum: HoneycombsEnum) {
        self.honeycombsEnum = honeycombsEnum
    }
}
