import Foundation

final class HistoryModel {

    private var profile: ProfileModel
    private var date: Date?
    private var passedQuestions: [QuestionModel]?
    private var failedQuestions: [QuestionModel]?
    
    init(profile: ProfileModel) {
        self.profile = profile
    }
}


//MARK:- setters

extension HistoryModel {
    
    func setDate(date: Date) {
        self.date = date
    }
    
    func setPassedQuestion(question: QuestionModel) {
        if passedQuestions == nil {
            passedQuestions = []
        }
        passedQuestions?.append(question)
    }
    
    func setFailedQuestion(question: QuestionModel) {
        if failedQuestions == nil {
            failedQuestions = []
        }
        failedQuestions?.append(question)
    }
}


//MARK:- getters

extension HistoryModel {
    
    func getDate() -> Date? {
        return date
    }
    
    func getPassedQuestions() -> [QuestionModel]? {
       return passedQuestions
    }
    
    func getFailedQuestion() -> [QuestionModel]? {
        return failedQuestions
    }
}
