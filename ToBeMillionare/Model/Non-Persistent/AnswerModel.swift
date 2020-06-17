import Foundation


final class AnswerModel {
    
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
