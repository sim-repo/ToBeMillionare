import Foundation


//MARK:- Base
protocol PresentableView: class {
}

//MARK:- Menu
protocol PresentableMenuView: PresentableView {
    func performPlaySegue()
    func performLeaderboardSegue()
    func performOptionsSegue()
}


//MARK:- Play
protocol PresentablePlayView: PresentableView {
    func startCountdown()
    func stopCountdown()
    func prepareForNextLevel()
    func showQuestion(question: ReadableQuestion)
    func perfomFinishSegue()
    func performScoreSegue()
    func gotoMainMenu()
    func showAuditoryHint(fractionA: Double, fractionB: Double, fractionC: Double, fractionD: Double)
    func showFiftyPercentHint(wrongFirstAnswerId: Int, wrongSecondAnswerId: Int)
    func performCallFriendSegue()
    func showGameOver()
    func showSuccess(levelEnum: LevelEnum, _ completion: (()->Void)?)
    func openTrueAnswer(_ rightAnswerId: String, _ completion: (()->Void)?)
    func startBlinkAnimation(_ selectedAnswerId: String, _ completion: (()->Void)?)
    func blur(enabled: Bool)
}


//MARK:- Score
protocol PresentableScoreView: PresentableView {
    func startAnimate(prevLevelEnum: LevelEnum, curLevelEnum: LevelEnum)
}


//MARK:- Leaderboard
protocol PresentableLeaderboardView: PresentableView {
    func reloadData()
}

//MARK:- Profile
protocol PresentableProfileView: PresentableView {
    func performNewProfileSegue()
    func performMainSegue()
}

//MARK:- New Profile
protocol PresentableCreateProfileView: PresentableView {
    func performProfileSegue()
    func performMenuSegue()
    
    func alertNameIsEmpty()
    func alertAgeIsEmpty()
    func alertAvaIsEmpty()
}


//MARK:- Leaderboard
protocol PresentableOptionsView: PresentableView {
    func setGameMode(modeEnum: GameModeEnum)
    func setUsePassedQuestions(enabled: Bool)
}


//MARK:- Call Friends
protocol PresentableCallFriendsView: PresentableView {
    func showFriendAnswer(answerId: String)
}

//MARK:- Presentable View
protocol PresentableFinishView: PresentableView {
    func gotoMainMenu()
}
