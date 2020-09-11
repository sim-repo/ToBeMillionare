//
//  OnBoardBkg.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 31.08.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

//#0005
class OnBoardBkg: UIView {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        if ScreenResolutionsEnum.screen() == .screen_47 {
            OnboardKit.drawOnboardBkgView_47(frame: bounds, resizing: .aspectFit)
        } else if ScreenResolutionsEnum.screen() == .screen_55 {
            OnboardKit.drawOnboardBkgView_55(frame: bounds, resizing: .aspectFit)
        } else if ScreenResolutionsEnum.screen() == .screen_58 {
            OnboardKit.drawOnboardBkgView_58(frame: bounds, resizing: .aspectFit)
        } else if ScreenResolutionsEnum.screen() == .screen_65 {
            OnboardKit.drawOnboardBkgView_65(frame: bounds, resizing: .aspectFit)
        }
    }
}

