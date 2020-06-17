import Foundation


final class ExistingPlayerGameBuilder: GameBuilderProtocol {
    
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
    
    private func loadQuestions(_ profile: ReadableProfile) -> [QuestionModel] {
        return RealmService.loadQuestions(profile.getGameMode(),
                                          profile.getUsePassedQuestions())
    }
    
    private func loadLeaderboard(_ profile: ReadableProfile) -> [LeaderboardModel]? {
        return RealmService.loadLeaderboard(profile.getGameMode())
    }
}
