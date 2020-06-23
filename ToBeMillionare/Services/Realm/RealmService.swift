import Foundation


class RealmService {

}


// load
extension RealmService {
    public static func loadQuestions(_ gameMode: GameModeEnum) -> [QuestionModel] {
        return getDiffQuestions()
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
    
    public static func loadHistory(gameModeEnum: GameModeEnum) -> [HistoryModel]? {
        return nil
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
