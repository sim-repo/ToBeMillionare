//
//  BonusReasonEnum.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 20.08.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import Foundation


enum BonusReasonEnum: String {
    
    case dailyRetension, dailySpeed, dailyDegree, none
    
    static func getBonusAmount(dailyDiffPercent: Double) -> Double {
        switch dailyDiffPercent {
            case 10...30:
                return 20
            case 31...50:
                return 40
            case 51...70:
                return 60
            case 71...90:
                return 80
            case 91...:
                return 100
            default:
                return 0
        }
    }
}
