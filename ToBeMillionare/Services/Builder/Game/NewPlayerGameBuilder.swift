import Foundation


final class NewPlayerGameBuilder: GameBuilderProtocol {
    
    func build(_ profile: ReadableProfile) -> GameModel {
        let game: GameModel = GameModel()
        game.setProfile(profile)
        
        //questions
        let questions = loadQuestions(profile)
        game.setQuestions(questions)
        
        //leaderboard
        if let leaderboard = loadLeaderboard(profile) {
            game.setLeaderboards(leaderboard)
        }
        return game
    }
    
    private func saveProfile(_ profile: ReadableProfile) {
        RealmService.saveProfile(profile)
    }
    
    private func loadQuestions(_ profile: ReadableProfile) -> [QuestionModel] {
        return RealmService.loadQuestions(profile.getGameMode(),
                                          profile.getUsePassedQuestions())
    }
    
    private func loadLeaderboard(_ profile: ReadableProfile) -> [LeaderboardModel]? {
        return RealmService.loadLeaderboard(profile.getGameMode())
    }
}
