//
//  CommonScreen.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 22.07.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//


import UIKit


class CommonScreen: UIView {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        if ScreenResolutionsEnum.screen() == .screen_47 {
            CommonKit.drawCommonScreen_47(frame: bounds,
                                          resizing: .aspectFit,
                                          starBlink: 0.0,
                                          tubeOvalOffset: 0.25)
        } else if ScreenResolutionsEnum.screen() == .screen_55 {
            CommonKit.drawCommonScreen_55(frame: bounds,
            resizing: .aspectFit,
            starBlink: 0.0,
            tubeOvalOffset: 0.25)
        } else if ScreenResolutionsEnum.screen() == .screen_58 {
            CommonKit.drawCommonScreen_58(frame: bounds,
            resizing: .aspectFit,
            starBlink: 0.0,
            tubeOvalOffset: 0.25)
        } else if ScreenResolutionsEnum.screen() == .screen_65 {
            CommonKit.drawCommonScreen_65(frame: bounds,
            resizing: .aspectFit,
            starBlink: 0.0,
            tubeOvalOffset: 0.25)
        }
    }
}
