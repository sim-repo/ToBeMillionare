import Foundation


final class QuestionModel: Codable {
 
    var id: Int
    var minRoundEnum: RoundEnum
    var maxRoundEnum: RoundEnum
    var question: String
    var answers: [AnswerModel]
    var gameModeEnum: GameModeEnum
    var occupationEnum: OccupationEnum
    
    init(id: Int, minRoundEnum: RoundEnum, maxRoundEnum: RoundEnum, question: String, answers: [AnswerModel], gameModeEnum: GameModeEnum, occupationEnum: OccupationEnum) {
        self.id = id
        self.minRoundEnum = minRoundEnum
        self.maxRoundEnum = maxRoundEnum
        self.question = question
        self.answers = answers
        self.gameModeEnum = gameModeEnum
        self.occupationEnum = occupationEnum
    }
    
    

    
    //MARK:- Codable >>
    
    enum CodingKeys: String, CodingKey {
        case id
        case minRoundEnum
        case maxRoundEnum
        case question
        case answers
        case gameModeEnum
        case occupationEnum
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(minRoundEnum.rawValue, forKey: .minRoundEnum)
        try container.encode(maxRoundEnum.rawValue, forKey: .maxRoundEnum)
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
        
        var stringRound = try container.decode(Int.self, forKey: .minRoundEnum)
        self.minRoundEnum = RoundEnum.init(rawValue: stringRound)!
     
        stringRound = try container.decode(Int.self, forKey: .maxRoundEnum)
        self.maxRoundEnum = RoundEnum.init(rawValue: stringRound)!
        
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
    
    func getMinRoundEnum() -> RoundEnum {
        return minRoundEnum
    }
    
    func getMaxRoundEnum() -> RoundEnum {
        return minRoundEnum
    }
}
