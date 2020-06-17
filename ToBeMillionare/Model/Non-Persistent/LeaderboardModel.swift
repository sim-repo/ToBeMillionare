import Foundation


final class LeaderboardModel {
    
    private var id: Int
    private var rank: Int
    private var playerName: String
    private var levelEnum: LevelEnum
    private var score: Int
    
    
    init(id: Int, rank: Int, playerName: String,  levelEnum: LevelEnum, score: Int){
        self.id = id
        self.rank =  rank
        self.playerName = playerName
        self.levelEnum = levelEnum
        self.score = score
    }
}

//MARK:- setters

extension LeaderboardModel: WritableLeaderboard {
    
    func setRank(rank: Int) {
        self.rank = rank
    }
    
    func setScore(score: Int) {
        self.score = score
    }
}



//MARK:- getters

extension LeaderboardModel: ReadableLeaderboard {
    
    func getRank() -> Int {
        return rank
    }
    
    func getPlayerName() -> String {
        return playerName
    }
    
    func getScore() -> Int {
        return score
    }
    
    func getLevel() -> LevelEnum {
        return levelEnum
    }
}


