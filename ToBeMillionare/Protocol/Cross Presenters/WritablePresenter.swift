import Foundation


//MARK:- Profile
protocol OptionableProfilePresenter: ReadableProfilePresenter {
    func setGameMode(modeEnum: GameModeEnum)
}


//MARK:- Score
protocol WritableScorePresenter: class {
    func setRound(prevRoundEnum: RoundEnum, curRoundEnum: RoundEnum)
}



//MARK:- Play
protocol WritablePlayPresenter: class {
    func setBetPercentOfDepo(betPercentOfDepo: Double)
}
