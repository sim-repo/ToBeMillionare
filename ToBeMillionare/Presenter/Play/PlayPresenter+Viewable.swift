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
        guard gameSessionService.isUsedFriendHint() == false else { return }
        vc?.performCallFriendSegue()
    }
    
    
    func didPressUseAuditoryHint() {
        guard gameSessionService.isUsedAuditoryHint() == false else { return }
        let percents = gameSessionService.getAuditoryHint()
        vc?.showAuditoryHint(fractionA: percents[0], fractionB: percents[1], fractionC: percents[2], fractionD: percents[3])
    }
    
    
    func didPressUseFiftyHint() {
        guard gameSessionService.isUsedFiftyHint() == false else { return }
        let wrongAnswerIds = gameSessionService.getFiftyHintWrongIds()
        vc?.showFiftyHint(wrongFirstAnswerId: wrongAnswerIds[0], wrongSecondAnswerId: wrongAnswerIds[1])
    }
    
    
    func didPressSelectAnswer(selectedAnswerId: String) {
        let completion: (()->Void)? = {[weak self] in
            guard let self = self else { return }
            let rightAnswerId = self.gameSessionService.getRightAnswerId(questionId: self.curQuestion.getQuestionId())
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
        return gameSessionService.isUsedFriendHint()
    }
    
    
    func getUsedAuditoryHint() -> Bool {
        return gameSessionService.isUsedAuditoryHint()
    }
    
    
    func getUsedFiftyHint() -> Bool {
        return gameSessionService.isUsedFiftyHint()
    }
    
    
    func getNextQuestion() -> String {
        curQuestion = gameSessionService.getQuestion(curLevel: gameSessionService.getLevel())
        return curQuestion.getQuestionText()
    }
    
    
    func getAnswers() -> [ReadableAnswer] {
        return gameSessionService.getAnswers(questionId: curQuestion.getQuestionId())
    }
}
