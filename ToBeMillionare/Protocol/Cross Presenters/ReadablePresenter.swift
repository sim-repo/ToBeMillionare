import Foundation


//MARK:- Profile
protocol ReadableProfilePresenter {
    func getSelected() -> ReadableProfile
}

//MARK:- Game
protocol ReadableGamePresenter {
    func getQuestion(curLevel: LevelEnum) -> ReadableQuestion
    func getRightAnswerId(questionId: Int) -> String
    func getAnswers(questionId: Int) -> [ReadableAnswer]
    func getFriendAnswer(questionId: Int, occupationEnum: OccupationEnum) -> ReadableAnswer
}

//MARK:- Play
protocol ReadablePlayPresenter {
    func getCurQuestionId() -> Int
}

