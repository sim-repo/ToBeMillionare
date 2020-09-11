//
//  PlayPrsenter+Writable.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 25.07.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import Foundation



//MARK:- Readable

extension PlayPresenter: WritablePlayPresenter {
    
    func setBetPercentOfDepo(betPercentOfDepo: Double) {
        self.tmpOldDepo = getDepo()
        sessionService.setBetPercentOfDepo(betPercentOfDepo: betPercentOfDepo)
    }
}

