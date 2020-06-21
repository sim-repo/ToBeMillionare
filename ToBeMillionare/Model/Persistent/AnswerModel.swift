import Foundation


final class AnswerModel: Codable {
    
    private var questionId: Int
    private var answerId: String
    private var answerText: String
    private var isTrue: Bool = false
    
    init(questionId: Int, answerId: String, answerText: String, isTrue: Bool) {
        self.questionId = questionId
        self.answerId = answerId
        self.answerText = answerText
        self.isTrue = isTrue
    }
    
    
    //MARK:- Codable >>
    
    enum CodingKeys: String, CodingKey {
        case questionId
        case answerId
        case answerText
        case isTrue
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(questionId, forKey: .questionId)
        try container.encode(answerId, forKey: .answerId)
        try container.encode(answerText, forKey: .answerText)
        try container.encode(isTrue, forKey: .isTrue)
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        questionId = try container.decode(Int.self, forKey: .questionId)
        answerId = try container.decode(String.self, forKey: .answerId)
        answerText = try container.decode(String.self, forKey: .answerText)
        isTrue = try container.decode(Bool.self, forKey: .isTrue)
    }
}


//MARK: - getters
extension AnswerModel: ReadableAnswer {
    
    func getAnswerId() -> String {
        return answerId
    }
    
    func getAnswerText() -> String {
        return answerText
    }
    
    func getIsTrue() -> Bool {
        return isTrue
    }
}
