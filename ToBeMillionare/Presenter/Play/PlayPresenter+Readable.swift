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
        return gameSessionModel.getLevel()
    }
    
    func getCurQuestionId() -> Int {
        return curQuestionId
    }
    
    func getAward() -> String {
        if let idx = gameSessionModel.getLevel().index {
            let prevIdx = idx - 1
            guard prevIdx >= 0 else { return "" }
            let passedLevel = LevelEnum.allCases[prevIdx]
            return LevelEnum.getAward(levelEnum: passedLevel)
        }
        return ""
    }
    
    func getFriendAnswer(questionId: Int, occupationEnum: OccupationEnum) -> ReadableAnswer {
        return gameSessionService.getFriendAnswer(questionId: questionId, occupationEnum: occupationEnum)
    }
}
