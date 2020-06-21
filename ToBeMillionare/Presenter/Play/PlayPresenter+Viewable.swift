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
        showQuestion()
        PresenterFactory.shared.dismisPresenter(clazz: ScorePresenter.self)
    }
    
    func didNextLevelAnimated() {
         showQuestion()
    }
    
    func setView(vc: PresentableView) {
        self.vc = vc as? PresentablePlayView
    }
    
    
    func didPressUseFriendHint() {
        guard gameSessionService.getUsedFriendHint() == false else { return }
        gameSessionService.setUsedFriendHint(enabled: true)
        vc?.performCallFriendSegue()
    }
    
    
    func didPressUseAuditoryHint() {
        guard gameSessionService.getUsedAuditoryHint() == false else { return }
        gameSessionService.setUsedAuditoryHint(enabled: true)
        vc?.showAuditoryHint(fractionA: 0.3, fractionB: 0.2, fractionC: 0.2, fractionD: 0.3)
    }
    
    
    func didPressUseFiftyHint() {
        guard gameSessionService.getUsedFiftyHint() == false else { return }
        gameSessionService.setUsedFiftyHint(enabled: true)
        
        let wrongAnswerIds = gameSessionService.getFiftyPercentWrongIds()
        vc?.showFiftyPercentHint(wrongFirstAnswerId: wrongAnswerIds[0], wrongSecondAnswerId: wrongAnswerIds[1])
    }
    
    
    func didPressSelectAnswer(selectedAnswerId: String) {
        let completion: (()->Void)? = {[weak self] in
            guard let self = self else { return }
            let rightAnswerId = self.gameSessionService.getRightAnswerId(questionId: self.curQuestionId)
            self.vc?.openTrueAnswer(rightAnswerId) { [weak self] in
                guard let self = self else { return }
                
                if rightAnswerId == selectedAnswerId  {
                    self.goNextLevel()
                    return
                }
                
                if self.isNeedShowGameOver() {
                    return 
                }
                
                self.finish()
            }
        }
        vc?.startBlinkAnimation(selectedAnswerId, completion)
    }
    
    func didPressFinish() {
        finish()
    }
    
    func didTimeout() {
        timeout()
    }
    
    func getUsedFriendHint() -> Bool {
        return gameSessionService.getUsedFriendHint()
    }
    
    
    func getUsedAuditoryHint() -> Bool {
        return gameSessionService.getUsedAuditoryHint()
    }
    
    
    func getUsedFiftyHint() -> Bool {
        return gameSessionService.getUsedFiftyHint()
    }
    
    
    func getQuestion() -> String {
        let question = gameSessionService.getQuestion(curLevel: gameSessionService.getLevel())
        curQuestionId = question.getQuestionId()
        return question.getQuestionText()
    }
    
    
    func getAnswers() -> [ReadableAnswer] {
        return gameSessionService.getAnswers(questionId: curQuestionId)
    }
}
