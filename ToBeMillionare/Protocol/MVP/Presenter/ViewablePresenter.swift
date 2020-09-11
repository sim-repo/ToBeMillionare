import Foundation

//MARK:- Base
protocol ViewablePresenter: PresenterProtocol {
    func setView(vc: PresentableView)
}


//MARK:- Menu
protocol ViewableMenuPresenter: ViewablePresenter {
    func didPressPlay()
    func didPressLeaderboard()
    func didPressOptions()
    func viewDidAppear()
    func getAvaURL() -> URL
    func getDepo() -> Double
    func getCurrentStage() -> Int
    func getCurrencySymbol() -> String
}



//MARK:- Play
protocol ViewablePlayPresenter: ViewablePresenter {
    func viewDidAppear()
    func didShownAllQuestions()
    func didNextRoundAnimated()
    func didPressUseFriendHint()
    func didPressUseAuditoryHint()
    func didPressUseFiftyHint()
    func didPressSelectAnswer(selectedAnswerId: String, spentTime: Int)
    func didPressFinish()
    func didPressDialogIsContinue(isContinue: Bool)
    func didTimeout()
    func getUsedFriendHint() -> Bool
    func getUsedAuditoryHint() -> Bool
    func getUsedFiftyHint() -> Bool
    func getNextQuestion() -> String
    func getAnswers() -> [ReadableAnswer]
    func getDepo() -> Double
    func getStageAim() -> Double
}


//MARK:- Progress
protocol ViewableProgressPresenter: ViewablePresenter {
    
    func viewWillAppear()
    func radar_getCurrentRetension() -> Double
    func radar_getCurrentSpeed() -> Double
    func radar_getCurrentDegree() -> Double
    
    func bar_getCurrentRetension() -> Double
    func bar_getCurrentSpeed() -> Double
    func bar_getCurrentDegree() -> Double
    
    func bar_getSpeedByDays() -> [Double]?
    func bar_getRetensionByDays() -> [Double]?
    func bar_getDegreeByDays() -> [Double]?
    
    func bar_getTargetLineY(achievementGroupEnum : AchievementGroupEnum) -> Double
    func bar_getTargetLineText(achievementGroupEnum : AchievementGroupEnum) -> String?
    
    func didPressBonusRetension()
    func didPressBonusSpeed()
    func didPressBonusDegree()
}



//MARK:- Leaderboard
protocol ViewableLeaderboardPresenter: ViewablePresenter {
    func numberOfSections() -> Int
    func numberOfRowsInSection() -> Int
    func getData(indexPath: IndexPath) -> LeaderboardModel?
}


//MARK:- Options
protocol ViewableOptionsPresenter: ViewablePresenter {
    func getSelectMode() -> GameModeEnum
    func didSelectMode(modeEnum: GameModeEnum)
}


//MARK:- Profile
protocol ViewableProfilePresenter: ViewablePresenter {
    func viewDidAppear()
    func numberOfRowsInSection() -> Int
    func getData(_ indexPath: IndexPath) -> ReadableProfile?
    func isSelected(_ indexPath: IndexPath) -> Bool
    func didSelectProfile(_ indexPath: IndexPath)
}


//MARK:- Create Profile
protocol ViewableCreateProfilePresenter: ViewablePresenter {
    func numberOfRowsInSection() -> Int
    func getData(_ indexPath: IndexPath) -> URL
    func isSelected(_ indexPath: IndexPath) -> Bool
    func didInputName(name: String)
    func didInputAge(age: Int)
    func didSelectAva(_ indexPath: IndexPath)
    func didDeselectAva(_ indexPath: IndexPath)
    func didSubmitProfile()
    func didCancel()
}


//MARK:- Options
protocol ViewableScorePresenter: ViewablePresenter {
    func viewDidAppear()
}


//MARK:- Call Friends
protocol ViewableCallFriendsPresenter: ViewablePresenter {
    func didSelectFriend(occupationEnum: OccupationEnum)
    func getQuestion() -> String
}




//MARK:- Finish
protocol ViewableFinishPresenter: ViewablePresenter {
    func getPlayerName() -> String
    func getAward() -> Double
}
