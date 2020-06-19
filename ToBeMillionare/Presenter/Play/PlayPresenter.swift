import Foundation


final class PlayPresenter {
    
    internal var vc: PresentablePlayView?
    
    internal var gameSessionModel: GameSessionModel = GameSessionModel()
    
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
    
    
    internal func setNextLevel() {
        if let idx = gameSessionModel.getLevel().index {
            let nextIdx = idx + 1
            let level = LevelEnum.allCases[nextIdx]
            gameSessionModel.setLevel(levelEnum: level)
        }
    }
    
    internal func getLevel(offset: Int) -> LevelEnum {
        let idx = gameSessionModel.getLevel().index!
        let nextIdx = idx + offset
        guard nextIdx >= 0 else { return .level1 }
        let level = LevelEnum.allCases[nextIdx]
        return level
    }
}

