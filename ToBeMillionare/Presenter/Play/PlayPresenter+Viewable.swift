//
//  PlayPresenter+Viewable.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 19.06.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import Foundation


//MARK:- Viewable
extension PlayPresenter: ViewablePlayPresenter {
    
    func viewDidAppear() {
        vc?.prepareForNextLevel()
        let question = gameSessionService.getQuestion(curLevel: gameSessionModel.getLevel())
        curQuestionId = question.getQuestionId()
        vc?.showQuestion(question: question)
    }
    
    func setView(vc: PresentableView) {
        self.vc = vc as? PresentablePlayView
    }
    
    
    func didPressUseFriendHint() {
        guard gameSessionModel.getUsedFriendHint() == false else { return }
        gameSessionModel.setUsedFriendHint(enabled: true)
        vc?.performCallFriendSegue()
    }
    
    
    func didPressUseAuditoryHint() {
        guard gameSessionModel.getUsedAuditoryHint() == false else { return }
        gameSessionModel.setUsedAuditoryHint(enabled: true)
        vc?.showAuditoryHint(fractionA: 0.3, fractionB: 0.2, fractionC: 0.2, fractionD: 0.3)
    }
    
    
    func didPressUseFiftyHint() {
        guard gameSessionModel.getUsedFiftyHint() == false else { return }
        gameSessionModel.setUsedFiftyHint(enabled: true)
        vc?.showFiftyPercentHint(wrongFirstAnswerId: 2, wrongSecondAnswerId: 4)
    }
    
    
    func didPressSelectAnswer(selectedAnswerId: String) {
        
        let completion: (()->Void)? = {[weak self] in
            guard let self = self else { return }
            let rightAnswerId = self.gameSessionService.getRightAnswerId(questionId: self.curQuestionId)
            self.vc?.openTrueAnswer(rightAnswerId) { [weak self] in
                guard let self = self else { return }
                if rightAnswerId == selectedAnswerId  {
                    self.setNextLevel()
                    self.vc?.showSuccess(levelEnum: self.gameSessionModel.getLevel()) { [weak self] in
                        guard let self = self else { return }
                        self.scorePresenter.setLevel(
                            prevLevelEnum: self.getLevel(offset: -2),
                            curLevelEnum: self.getLevel(offset: -1))
                        self.vc?.performScoreSegue()
                    }
                    return
                }
                
                if let level = Int(self.gameSessionModel.getLevel().rawValue),
                    level < 1000 {
                    self.vc?.blur(enabled: true)
                    self.vc?.showGameOver()
                    return
                }
                self.vc?.performScoreSegue()
            }
        }
        vc?.startBlinkAnimation(selectedAnswerId, completion)
    }
    
    
    func didPressFinish() {
        if gameSessionModel.getLevel() == .level1 {
            vc?.gotoMainMenu()
            return
        }
        vc?.perfomFinishSegue()
    }
    
    
    // getters
    
    func getUsedFriendHint() -> Bool {
        return gameSessionModel.getUsedFriendHint()
    }
    
    
    func getUsedAuditoryHint() -> Bool {
        return gameSessionModel.getUsedAuditoryHint()
    }
    
    
    func getUsedFiftyHint() -> Bool {
        return gameSessionModel.getUsedFiftyHint()
    }
    
    
    func getQuestion() -> String {
        let question = gameSessionService.getQuestion(curLevel: gameSessionModel.getLevel())
        curQuestionId = question.getQuestionId()
        return question.getQuestionText()
    }
    
    
    func getAnswers() -> [ReadableAnswer] {
        return gameSessionService.getAnswers(questionId: curQuestionId)
    }
    
    func didTimeout() {
        if let level = Int(self.gameSessionModel.getLevel().rawValue),
            level < 1000 {
            self.vc?.showGameOver()
            return
        }
        self.vc?.performScoreSegue()
    }
}
