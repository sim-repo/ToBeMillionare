//
//  Screen.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 16.07.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

enum ScreenResolutionsEnum {
    case screen_47 // 375*667   iphone 6,6s,7,8
    case screen_55 // 414*736   iphone 6+,6s+,7+,8+
    case screen_58 // 375*812   iphone 11 Pro,X,Xs
    case screen_65 // 414*896   iphone 11 Pro Max, Xs Max, 11, Xr
    
    static func screen() -> ScreenResolutionsEnum {
        let screenSize = UIScreen.main.bounds
        let w = screenSize.width
        let h = screenSize.height
        if w == 375 && h == 667 {
            return screen_47
        }
        
        if w == 414 && h == 736 {
            return screen_55
        }
        
        if w == 375 && h == 812 {
            return screen_58
        }
        
        if w == 414 && h == 896 {
            return screen_65
        }
        return screen_47
    }
}
