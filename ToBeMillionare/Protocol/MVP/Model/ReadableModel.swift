import Foundation


//MARK:- Profile
protocol ReadableProfile: class {
    func getId() -> Int
    func getName() -> String
    func getAge() -> Int
    func getAva() -> URL
    func isFakeProfile() -> Bool
    func getGameMode() -> GameModeEnum
    func getDepo() -> Double
    func getDateCreate() -> Date
    func getAchievementEnums() -> [AchievementEnum]
    func getDaysBeforeDisaster() -> Int
    func getStage() -> Int
    func getUsedTipRenewFireproof() -> Bool
}


//MARK:- Template Profile
protocol ReadableTemplateProfile {
    func getAvaURLs() -> [URL]
    func getMiniAvaURLs() -> [URL]
}

//MARK:- Leaderboard
protocol ReadableLeaderboard: class {
    func getRank() -> Int
    func getPlayerName() -> String
    func getScore() -> Int
    func getRound() -> RoundEnum
}


//MARK:- Question
protocol ReadableQuestion: class {
    func getQuestionId() -> Int
    func getQuestionText() -> String
    func getAnswers() -> [ReadableAnswer]
    func getGameModeEnum() -> GameModeEnum
    func getMinRoundEnum() -> RoundEnum
    func getMaxRoundEnum() -> RoundEnum
}



//MARK:- Answer
protocol ReadableAnswer: class {
    func getAnswerId() -> String
    func getAnswerText() -> String
    func getIsTrue() -> Bool
}


//MARK:- History
protocol ReadableHistory: class {
    func getId() -> Int
    func getDate() -> Date
    func getPlayerId() -> Int
    func getRound() -> RoundEnum
    func getPassedQuestionIds() -> [Int]
    func getAccumulatedResponseTime() -> Int
    func getBetPercentOfDepo() -> Double
    func getBetResult() -> Double
}

//MARK:- Bonus History
protocol ReadableBonusHistory: class {
    func getId() -> Int
    func getPlayerId() -> Int
    func getCheckedSerialDay() -> Int
    func getCheckDate() -> Date
    func getReason() -> BonusReasonEnum
    func getBonusAmount() -> Double
    func getBonusCurrency() -> CurrencyEnum
    func getShownToPlayer() -> Bool
}
