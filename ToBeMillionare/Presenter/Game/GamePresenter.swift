import Foundation


final class GamePresenter: PresenterProtocol {
    private var gameModel: GameModel!
}



//MARK:- Writable
extension GamePresenter: WritableGameProtocol {
    
    func createGame(builder: GameBuilderProtocol, profile: ReadableProfile) {
        let gameDirector = GameDirector(builder: builder)
        gameModel = gameDirector.make(profile: profile)
    }
}


//MARK:- Readable
extension GamePresenter: ReadableGamePresenter {
    
    func getQuestion(curLevel: LevelEnum) -> ReadableQuestion {
        let questions = gameModel.getQuestions().filter{$0.levelEnum.rawValue == curLevel.rawValue}
        let rand = Int.random(in: 0...questions.count-1)
        return questions[rand]
    }
    
    
    func getRightAnswerId(questionId: Int) -> String {
        let question = gameModel.getQuestions().first(where: {$0.id == questionId})!
        let rightAnswerId = question.answers.first(where: { $0.getIsTrue() == true })!
        return rightAnswerId.getAnswerId()
    }
    
    
    func getAnswers(questionId: Int) -> [ReadableAnswer] {
        let question = gameModel.getQuestions().first(where: {$0.id == questionId})!
        return question.getAnswers()
    }
    
    func getFriendAnswer(questionId: Int, occupationEnum: OccupationEnum) -> ReadableAnswer {
        let question = gameModel.getQuestions().first(where: {$0.id == questionId})!
    
        if question.occupationEnum == occupationEnum {
            let trueAnswer = question.getAnswers().first(where: {$0.getIsTrue() == true })
            return trueAnswer!
        } else {
            let answers = question.getAnswers()
            let rand = Int.random(in: 0...answers.count-1)
            return answers[rand]
        }
    }
}

