import Foundation


final class QuestionModel {
    
    var id: Int
    var levelEnum: LevelEnum
    var question: String
    var answers: [AnswerModel]
    var gameModeEnum: GameModeEnum
    var occupationEnum: OccupationEnum
    
    init(id: Int, levelEnum: LevelEnum, question: String, answers: [AnswerModel], gameModeEnum: GameModeEnum, occupationEnum: OccupationEnum) {
        self.id = id
        self.levelEnum = levelEnum
        self.question = question
        self.answers = answers
        self.gameModeEnum = gameModeEnum
        self.occupationEnum = occupationEnum
    }
}

//MARK:- Readable

extension QuestionModel: ReadableQuestion {
    
    func getQuestionId() -> Int {
        return id
    }
    
    func getQuestionText() -> String {
        return question
    }
    
    func getAnswers() -> [ReadableAnswer] {
        return answers
    }
}
