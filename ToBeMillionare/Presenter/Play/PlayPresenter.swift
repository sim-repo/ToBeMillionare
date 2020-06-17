import Foundation


final class PlayPresenter {
    
    private var vc: PresentablePlayView?
    
    private var gameSessionModel: GameSessionModel = GameSessionModel()
    
    private var gamePresenter: ReadableGamePresenter {
        let presenter: GamePresenter = PresenterFactory.shared.getInstance()
        return presenter as ReadableGamePresenter
    }
    
    private var scorePresenter: WritableScorePresenter {
        let presenter: ScorePresenter = PresenterFactory.shared.getInstance()
        return presenter as WritableScorePresenter
    }
    
    
    private var curQuestionId: Int = 0
    
    
    private func setNextLevel() {
        if let idx = gameSessionModel.getLevel().index {
            let nextIdx = idx + 1
            let level = LevelEnum.allCases[nextIdx]
            gameSessionModel.setLevel(levelEnum: level)
        }
    }
    
    private func getLevel(offset: Int) -> LevelEnum {
        let idx = gameSessionModel.getLevel().index!
        let nextIdx = idx + offset
        guard nextIdx >= 0 else { return .level1 }
        let level = LevelEnum.allCases[nextIdx]
        return level
    }
}


//MARK:- Viewable
extension PlayPresenter: ViewablePlayPresenter {
    
    func viewDidAppear() {
        vc?.prepareForNextLevel()
        let question = gamePresenter.getQuestion(curLevel: gameSessionModel.getLevel())
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
            let rightAnswerId = self.gamePresenter.getRightAnswerId(questionId: self.curQuestionId)
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
                } else {
                    self.vc?.showFail()
                }
            }
        }
        vc?.startBlinkAnimation(selectedAnswerId, completion)
    }
    
    
    func didPressFinish() {
        vc?.perfomFinishSegue()
    }
    
    
    // getters
    func getLevel() -> LevelEnum {
        return gameSessionModel.getLevel()
    }
    
    
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
        let question = gamePresenter.getQuestion(curLevel: gameSessionModel.getLevel())
        curQuestionId = question.getQuestionId()
        return question.getQuestionText()
    }
    
    
    func getAnswers() -> [ReadableAnswer] {
        return gamePresenter.getAnswers(questionId: curQuestionId)
    }
    
    func didTimeout() {
        vc?.showFail()
    }
}


//MARK:- Readable

extension PlayPresenter: ReadablePlayPresenter {
    
    func getCurQuestionId() -> Int {
        return curQuestionId
    }
}
