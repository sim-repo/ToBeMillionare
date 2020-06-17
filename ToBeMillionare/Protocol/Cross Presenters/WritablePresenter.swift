import Foundation


//MARK:- Profile
protocol WritableProfilePresenter {
    func setGameMode(modeEnum: GameModeEnum)
    func setUsePassedQuestions(enabled: Bool)
}


//MARK:- Game
protocol WritableGameProtocol {
    func createGame(builder: GameBuilderProtocol, profile: ReadableProfile)
}


//MARK:- Score
protocol WritableScorePresenter {
    func setLevel(prevLevelEnum: LevelEnum, curLevelEnum: LevelEnum)
}

