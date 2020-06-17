import Foundation


final class GameModel {

    private var profile: ReadableProfile!
    private var questions: [QuestionModel] = []
    private var leaderboards: [LeaderboardModel] = []
}



//MARK: - setters
extension GameModel {

    public func setProfile(_ profile: ReadableProfile) {
        self.profile = profile
    }
    
    public func setQuestions(_ questions: [QuestionModel]) {
        self.questions = questions
    }
    
    public func setLeaderboards(_ leaderboards: [LeaderboardModel]) {
        self.leaderboards = leaderboards
    }
}


//MARK: - getters
extension GameModel {

    public func getProfile() -> ReadableProfile {
        return profile
    }
    
    public func getQuestions() -> [QuestionModel] {
        return questions
    }
    
    public func getLeaderboards() -> [LeaderboardModel] {
        return leaderboards
    }
}
