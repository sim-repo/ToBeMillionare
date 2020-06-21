import Foundation


final class PlayPresenter {
    
    internal weak var vc: PresentablePlayView?
    internal var gameSessionService: GameSessionService!
    
    internal var scorePresenter: WritableScorePresenter {
        let presenter: ScorePresenter = PresenterFactory.shared.getInstance()
        return presenter as WritableScorePresenter
    }
    
    internal var profilePresenter: ReadableProfilePresenter {
        let presenter: ProfilePresenter = PresenterFactory.shared.getInstance()
        return presenter as ReadableProfilePresenter
    }
    
    internal var curQuestionId: Int = 0
    
    init(){
        gameSessionService = GameSessionService(profile: profilePresenter.getSelected())
    }
}


//MARK:- 

extension PlayPresenter {
    
    
    internal func showQuestion() {
        vc?.prepareForNextLevel()
        let question = gameSessionService.getQuestion(curLevel: gameSessionService.getLevel())
        curQuestionId = question.getQuestionId()
        vc?.showQuestion(question: question)
    }
    
    internal func goNextLevel() {
        gameSessionService.setNextLevel()
        self.vc?.showSuccess(levelEnum: gameSessionService.getLevel()) { [weak self] in
            guard let self = self else { return }
            
            let levelInt = self.gameSessionService.getLevel().rawValue.replacingOccurrences(of: " ", with: "")
            
            guard let level = Int(levelInt),
                level >= 16000
                else {
                    self.vc?.showNextLevelView(levelEnum: self.gameSessionService.getLevel(offset: -1))
                    return }
            
            self.scorePresenter.setLevel(
                prevLevelEnum: self.gameSessionService.getLevel(offset: -2),
                curLevelEnum: self.gameSessionService.getLevel(offset: -1))
            self.vc?.performScoreSegue()
        }
    }
    
    
    internal func isNeedShowGameOver() -> Bool {
        guard let level = Int(gameSessionService.getLevel().rawValue),
            level < 1000
            else {
                return false
        }
        gameSessionService.setFinishSession()
        vc?.blur(enabled: true)
        vc?.showGameOver()
        return true
    }
    
    
    internal func finish() {
        gameSessionService.setFinishSession()
        if gameSessionService.getLevel() == .level1 {
            vc?.gotoMainMenu()
            return
        }
        vc?.perfomFinishSegue()
    }
    
    
    
    internal func timeout() {
        if let level = Int(gameSessionService.getLevel().rawValue),
            level < 1000 {
            vc?.showGameOver()
            return
        }
        vc?.perfomFinishSegue()
    }
}

