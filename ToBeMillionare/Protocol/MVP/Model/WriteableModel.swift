import Foundation


//MARK:- Profile
protocol WriteableProfile: class {
    
    func setAva(ava: URL)

    func setAge(age: Int)

    func setName(name: String)

    func setGameMode(modeEnum: GameModeEnum)

    func setUsePassedQuestions(enabled: Bool)
}




//MARK:- Leaderboard
protocol WritableLeaderboard: class {
    
    func setRank(rank: Int)
    
    func setScore(score: Int)
}
