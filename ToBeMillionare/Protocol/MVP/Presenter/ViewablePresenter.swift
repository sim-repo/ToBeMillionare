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
}



//MARK:- Play
protocol ViewablePlayPresenter: ViewablePresenter {
    func getUsedFriendHint() -> Bool
    func getUsedAuditoryHint() -> Bool
    func getUsedFiftyHint() -> Bool
    func getQuestion() -> String
    func getAnswers() -> [ReadableAnswer]
    func didPressUseFriendHint()
    func didPressUseAuditoryHint()
    func didPressUseFiftyHint()
    func didPressSelectAnswer(selectedAnswerId: String)
    func didPressFinish()
    func didTimeout()
    func viewDidAppear()
    func didNextLevelAnimated()
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
}




//MARK:- Finish
protocol ViewableFinishPresenter: ViewablePresenter {
    func getPlayerName() -> String
    func getAward() -> String
}
