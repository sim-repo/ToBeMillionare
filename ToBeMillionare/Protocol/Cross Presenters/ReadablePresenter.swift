import Foundation


//MARK:- Profile
protocol ReadableProfilePresenter: class {
    func getSelected() -> ReadableProfile
}

//MARK:- Play
protocol ReadablePlayPresenter {
    func getRound() -> RoundEnum
    func getQuestion() -> String
    func getAward() -> Double
    func gotoMainMenu(deepness: Int)
    func getFriendAnswer(occupationEnum: OccupationEnum) -> ReadableAnswer
    func getDepo()->Double
    func getMinAward() -> Double
    func getMinBetSum() -> Double
    func getFireproofRound(_ cachedDepo: Double?) -> Int
    func getBetSum() -> Double
    func canSelectBet() -> Bool
    func getStageAim() -> Double
    func getGamesCount() -> Int
    func getStage() -> Int
    func getZondRecovery() -> Int
    func getDaysLeftBeforeDisaster() -> Int
    func getActualCurrency() -> CurrencyEnum
}

