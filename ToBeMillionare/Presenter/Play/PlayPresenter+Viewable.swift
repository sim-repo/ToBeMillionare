//
//  PlayPresenter+Viewable.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 19.06.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import Foundation


//MARK:- Viewable

// incoming events
extension PlayPresenter: ViewablePlayPresenter {
    
    func viewDidAppear() {
        showQuestion()
        PresenterFactory.shared.dismisPresenter(clazz: ScorePresenter.self)
    }
    
    
    func didNextRoundAnimated() {
        showQuestion()
    }
    
    
    func didShownAllQuestions() {
        isAnswerButtonReady = true
    }
    
    
    func didPressUseFriendHint() {
        guard canUsePlayingButton() else { return }
        guard isAnswerButtonReady else { return }
        guard sessionService.isUsedFriendHint() == false else { return }
        vc?.stopCountdown()
        vc?.performSegueCallFriend()
    }
    
    
    func didPressUseAuditoryHint() {
        guard canUsePlayingButton() else { return }
        guard sessionService.isUsedAuditoryHint() == false else { return }
        vc?.stopCountdown()
        let percents = sessionService.getAuditoryHint()
        vc?.showAuditoryHint(fractionA: percents[0], fractionB: percents[1], fractionC: percents[2], fractionD: percents[3])
    }
    
    
    func didPressUseFiftyHint() {
        guard canUsePlayingButton() else { return }
        guard sessionService.isUsedFiftyHint() == false else { return }
        vc?.stopCountdown()
        let wrongAnswerIds = sessionService.getFiftyHintWrongIds()
        vc?.showFiftyHint(wrongFirstAnswerId: wrongAnswerIds[0], wrongSecondAnswerId: wrongAnswerIds[1])
    }
    
    
    func didPressSelectAnswer(selectedAnswerId: String, spentTime: Int) {
        guard canUsePlayingButton() else { return }
        isAnswerButtonReady = false
        vc?.stopCountdown()
        let rightAnswerId = self.sessionService.getRightAnswerId(questionId: self.curQuestion.getQuestionId())
        self.vc?.openTrueAnswer(sessionService.getRound(), selectedAnswerId, rightAnswerId) { [weak self] in
            guard let self = self else { return }
            if rightAnswerId == selectedAnswerId  {
                self.tryNextRound(spentTime: spentTime)
                return
            }
            self.finish()
        }
    }
    
    
    func didPressFinish() {
        forceFinish()
    }
    
    
    func didTimeout() {
        timeout()
    }
    
    // #0001
    func didPressDialogIsContinue(isContinue: Bool) {
        if isContinue {
            goNextRound()
            sessionService.renewFireproof()
            return
        }
        finish()
    }
}


//MARK:- Viewable
extension PlayPresenter {
    
    func setView(vc: PresentableView) {
        self.vc = vc as? PresentablePlayView
    }
    
    
    private func canUsePlayingButton() -> Bool {
        return isAnswerButtonReady
    }
    
    
    func getUsedFriendHint() -> Bool {
        return sessionService.isUsedFriendHint()
    }
    
    
    func getUsedAuditoryHint() -> Bool {
        return sessionService.isUsedAuditoryHint()
    }
    
    
    func getUsedFiftyHint() -> Bool {
        return sessionService.isUsedFiftyHint()
    }
    
    
    func getNextQuestion() -> String {
        curQuestion = sessionService.getQuestion(curRound: sessionService.getRound())
        return curQuestion.getQuestionText()
    }
    
    
    func getAnswers() -> [ReadableAnswer] {
        return sessionService.getAnswers(questionId: curQuestion.getQuestionId())
    }
    
    
    public func getOldDepo() -> Double {
        return tmpOldDepo
    }
    
    
    public func getDividedRoundAward() -> Int {

        let round = getRound()
        var rem: Double = 0
        
        let fireproof = getFireproofRound()
        if round == .round2 {
            let r = tmpAward / Double(fireproof)
            let rounded = r.rounded(.toNearestOrEven)
            rem = r - rounded
        }
        return Int(tmpAward / Double(fireproof) + rem*Double(fireproof))
    }
}
