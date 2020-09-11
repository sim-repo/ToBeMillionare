import Foundation


//MARK:- Base
protocol PresentableView: class {
}

//MARK:- Menu
protocol PresentableMenuView: PresentableView {
    func performPlaySegue()
    func performProgressSegue()
    func performOptionsSegue()
}


//MARK:- Play
protocol PresentablePlayView: PresentableView {
    func startCountdown()
    func stopCountdown()
    func showNextRoundView(nextRoundEnum: RoundEnum)
    func showQuestion(roundEnum: RoundEnum, question: ReadableQuestion)
    func performSegueStat()
    func performSegueNextStage(stageNum: Int, zondRecovery: Int, daysBeforeDisaster: Int)
    func performSegueCallFriend()
    func gotoMainMenu(deepness: Int)
    func showAuditoryHint(fractionA: Double, fractionB: Double, fractionC: Double, fractionD: Double)
    func showFiftyHint(wrongFirstAnswerId: String, wrongSecondAnswerId: String)
    func showGameOver()
    func showSuccess(nextRoundEnum: RoundEnum, roundAward: Int, fireproofRemaining: Int, _ completion: (()->Void)?)
    func openTrueAnswer(_ roundEnum: RoundEnum, _ selectedAnswerId: String, _ rightAnswerId: String, _ completion: (()->Void)?)
    func blur(enabled: Bool)
    func showAchievement(achievementEnum: AchievementEnum)
    func showDialogRenewFireproof(title: String, desc: String)
    func showNotification(text: String)
}


//MARK:- Progress
protocol PresentableProgressView: PresentableView {
    func showRetensionIconBonus(hasBonus: Bool)
    func showSpeedIconBonus(hasBonus: Bool)
    func showDegreeIconBonus(hasBonus: Bool)
    
    func startRetensionBonusAnimation(bonusText: String)
    func startSpeedBonusAnimation(bonusText: String)
    func startDegreeBonusAnimation(bonusText: String)
}


//MARK:- Score
protocol PresentableScoreView: PresentableView {
    func startAnimate(prevRoundEnum: RoundEnum, curRoundEnum: RoundEnum)
}


//MARK:- Leaderboard
protocol PresentableLeaderboardView: PresentableView {
    func reloadData()
}

//MARK:- Profile
protocol PresentableProfileView: PresentableView {
    func performNewProfileSegue()
    func performMainSegue()
    func blink(itemIdx: Int)
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
}


//MARK:- Call Friends
protocol PresentableCallFriendsView: PresentableView {
    func showFriendAnswer(answerId: String)
}

//MARK:- Finish
protocol PresentableFinishView: PresentableView {
    func gotoMainMenu()
}




