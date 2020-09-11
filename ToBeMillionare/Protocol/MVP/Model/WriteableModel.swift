import Foundation


//MARK:- Leaderboard
protocol WritableLeaderboard: class {
    func setRank(rank: Int)
    func setScore(score: Int)
}
