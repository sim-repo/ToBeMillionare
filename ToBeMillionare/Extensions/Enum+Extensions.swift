//
//  Enum+Extensions.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 18.06.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import Foundation

extension CaseIterable where Self: Equatable {
    var index: Self.AllCases.Index? {
        return Self.allCases.firstIndex { self == $0 }
    }
}
