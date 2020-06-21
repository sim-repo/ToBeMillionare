import Foundation


final class QuestionModel: Codable {
 
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
    
    

    
    //MARK:- Codable >>
    
    enum CodingKeys: String, CodingKey {
        case id
        case levelEnum
        case question
        case answers
        case gameModeEnum
        case occupationEnum
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(levelEnum.rawValue, forKey: .levelEnum)
        try container.encode(question, forKey: .question)
        try container.encode(answers, forKey: .answers)
        try container.encode(gameModeEnum.rawValue, forKey: .gameModeEnum)
        try container.encode(occupationEnum.rawValue, forKey: .occupationEnum)
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        question = try container.decode(String.self, forKey: .question)
        self.answers = try container.decode([AnswerModel].self, forKey: .answers)
        
        let stringLevel = try container.decode(String.self, forKey: .levelEnum)
        self.levelEnum = LevelEnum.init(rawValue: stringLevel)!
     
        
        let stringGameMode = try container.decode(String.self, forKey: .gameModeEnum)
        self.gameModeEnum = GameModeEnum.init(rawValue: stringGameMode)!
        
        let stringOccupation = try container.decode(String.self, forKey: .occupationEnum)
        self.occupationEnum = OccupationEnum.init(rawValue: stringOccupation)!
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
    
    func getGameModeEnum() -> GameModeEnum {
        return gameModeEnum
    }
    
    func getLevelEnum() -> LevelEnum {
        return levelEnum
    }
}
