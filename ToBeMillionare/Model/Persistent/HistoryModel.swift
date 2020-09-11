import Foundation

final class HistoryModel: Codable {
    
    private var id: Int = 0
    private var playerId: Int = 0
    private var date: Date
    private var passedQuestionIds: [Int] = []
    private var roundEnum: RoundEnum = .round1
    private var accumulatedResponseTime: Int = 0
    private var betPercentOfDepo: Double = 0
    private var betResult: Double = 0
    
    internal init(id: Int, playerId: Int, date: Date) {
        self.id = id
        self.playerId = playerId
        self.date = date
    }
    
    //MARK:- Codable >>
    enum CodingKeys: String, CodingKey {
        case id
        case playerId
        case date
        case passedQuestionIds
        case roundEnum
        case accumulatedResponseTime
        case betPercentOfDepo
        case betResult
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(playerId, forKey: .playerId)
        try container.encode(date, forKey: .date)
        try container.encode(passedQuestionIds, forKey: .passedQuestionIds)
        try container.encode(roundEnum.rawValue, forKey: .roundEnum)
        try container.encode(accumulatedResponseTime, forKey: .accumulatedResponseTime)
        try container.encode(betPercentOfDepo, forKey: .betPercentOfDepo)
        try container.encode(betResult, forKey: .betResult)
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        playerId = try container.decode(Int.self, forKey: .playerId)
        date = try container.decode(Date.self, forKey: .date)
        passedQuestionIds = try container.decode([Int].self, forKey: .passedQuestionIds)
        let stringRound = try container.decode(Int.self, forKey: .roundEnum)
        self.roundEnum = RoundEnum.init(rawValue: stringRound)!
        accumulatedResponseTime = try container.decode(Int.self, forKey: .accumulatedResponseTime)
        betPercentOfDepo = try container.decode(Double.self, forKey: .betPercentOfDepo)
        betResult = try container.decode(Double.self, forKey: .betResult)
    }
}



//MARK:- setters

extension HistoryModel {
    
    func setPassedQuestion(questionId: Int) {
        passedQuestionIds.append(questionId)
    }
    
    func setRound(roundEnum: RoundEnum) {
        self.roundEnum = roundEnum
    }
    
    func setAccumulatedResponseTime(accumulatedResponseTime: Int) {
        self.accumulatedResponseTime = accumulatedResponseTime
    }
    
    func setBetPercentOfDepo(percent: Double) {
        self.betPercentOfDepo = percent
    }
    
    func setBetResult(sum: Double) {
        self.betResult = sum
    }
}


//MARK:- getters

extension HistoryModel: ReadableHistory {
    
    func getId() -> Int {
        return id
    }
    
    func getPlayerId() -> Int {
        return playerId
    }
    
    func getRound() -> RoundEnum {
        return roundEnum
    }
    
    func getDate() -> Date {
        return date
    }
    
    func getPassedQuestionIds() -> [Int] {
        return passedQuestionIds
    }
    
    func getAccumulatedResponseTime() -> Int {
        return accumulatedResponseTime
    }
    
    func getBetPercentOfDepo() -> Double {
        return betPercentOfDepo
    }
    
    func getBetResult() -> Double {
        return betResult
    }
}
