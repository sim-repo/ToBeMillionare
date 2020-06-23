import Foundation


//MARK:- Profile
protocol ReadableProfilePresenter {
    func getSelected() -> ReadableProfile
}

//MARK:- Play
protocol ReadablePlayPresenter {
    func getLevel() -> LevelEnum
    func getQuestion() -> String
    func getAward() -> String
    func gotoMainMenu()
    func getFriendAnswer(occupationEnum: OccupationEnum) -> ReadableAnswer
}

