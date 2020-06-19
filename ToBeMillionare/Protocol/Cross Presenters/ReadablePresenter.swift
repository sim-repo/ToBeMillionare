import Foundation


//MARK:- Profile
protocol ReadableProfilePresenter {
    func getSelected() -> ReadableProfile
}

//MARK:- Play
protocol ReadablePlayPresenter {
    func getLevel() -> LevelEnum
    func getCurQuestionId() -> Int
    func getAward() -> String
    func gotoMainMenu()
    func getFriendAnswer(questionId: Int, occupationEnum: OccupationEnum) -> ReadableAnswer
}

