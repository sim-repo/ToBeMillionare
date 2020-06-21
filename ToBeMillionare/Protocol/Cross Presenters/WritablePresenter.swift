import Foundation


//MARK:- Profile
protocol WritableProfilePresenter {
    func setGameMode(modeEnum: GameModeEnum)
    func setCreatedProfile(created: ProfileModel)
}

//MARK:- Score
protocol WritableScorePresenter {
    func setLevel(prevLevelEnum: LevelEnum, curLevelEnum: LevelEnum)
}

