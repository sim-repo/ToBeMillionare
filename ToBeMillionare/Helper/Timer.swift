//
//  Timer.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 13.08.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import Foundation

func mysleep(_ milliseconds: Double) {
    let second: Double = 1000000
    usleep(useconds_t(milliseconds * second))
}
