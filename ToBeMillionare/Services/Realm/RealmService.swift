import Foundation


class RealmService {

}


// load
extension RealmService {
    public static func loadQuestions(_ gameMode: GameModeEnum, _ usePassedQuestions: Bool) -> [QuestionModel] {
        return getEasyQuestions()
    }
    
    public static func loadLeaderboard(_ gameMode: GameModeEnum) -> [LeaderboardModel]? {
        return []
    }
    
    public static func loadProfiles() -> [ProfileModel] {
        return getProfiles()
    }
    
    public static func loadProfileTemplate() -> TemplateProfileModel {
        return getTemplateProfile()
    }
}


// save
extension RealmService {
    public static func saveQuestion(_ question: QuestionModel) {
    }
    
    public static func saveLeaderboard(_ leaderboard: ReadableLeaderboard) {
    }
    
    public static func saveProfile(_ profile: ReadableProfile) {
    }
}
