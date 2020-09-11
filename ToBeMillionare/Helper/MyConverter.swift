//
//  MyConverter.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 28.08.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import Foundation

final class MyConverter {
    
    static func stageToFraction(stage: Int, depo: Double) -> Double {
        let k: Double = 1.0/7000.0 //7000 - sum of money = 7 stages
        return (Double(stage * 1000) + depo)*k - 0.1
    }
    
    static func depoToFraction(depo: Double) -> Double {
        let k: Double = 1.0/1000.0 //7000 - sum of money = 7 stages
        return depo*k
    }
}
