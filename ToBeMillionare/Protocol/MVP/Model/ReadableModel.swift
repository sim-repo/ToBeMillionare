import Foundation


//MARK:- Profile
protocol ReadableProfile: class {
    
    func getId() -> Int
    
    func getName() -> String
    
    func getAge() -> Int
    
    func getAva() -> URL
    
    func isFakeProfile() -> Bool
    
    func getGameMode() -> GameModeEnum
    
    func getUsePassedQuestions() -> Bool
}


//MARK:- Template Profile
protocol ReadableTemplateProfile {
    
    func getAvaURLs() -> [URL]
}

//MARK:- Leaderboard
protocol ReadableLeaderboard: class {
    
    func getRank() -> Int
    
    func getPlayerName() -> String
    
    func getScore() -> Int
    
    func getLevel() -> LevelEnum
}


//MARK:- Question
protocol ReadableQuestion: class {
    
    func getQuestionId() -> Int
    func getQuestionText() -> String
    func getAnswers() -> [ReadableAnswer]
}



//MARK:- Answer
protocol ReadableAnswer: class {
    
    func getAnswerId() -> String
    
    func getAnswerText() -> String
    
    func getIsTrue() -> Bool
}

