//
//  PlayPresenter+Readable.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 19.06.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import Foundation



//MARK:- Readable

extension PlayPresenter: ReadablePlayPresenter {
    
    func gotoMainMenu() {
        vc?.gotoMainMenu()
    }
    
    func getLevel() -> LevelEnum {
        return gameSessionService.getLevel()
    }
    
    func getQuestion() -> String {
        return curQuestion.getQuestionText()
    }
    
    func getAward() -> String {
        return gameSessionService.getAward()
    }
    
    func getFriendAnswer(occupationEnum: OccupationEnum) -> ReadableAnswer {
        return gameSessionService.getFriendAnswer(occupationEnum: occupationEnum)
    }
}
