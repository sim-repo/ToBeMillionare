import Foundation

final class HistoryModel: Codable {
    
    private var id: Int = 0
    private var playerId: Int = 0
    private var date: Date
    private var passedQuestionIds: [Int]?
    private var levelEnum: LevelEnum = .level1
    private var usedFriendHint: Bool = false
    private var usedAuditoryHint: Bool = false
    private var usedFiftyHint: Bool = false
    
    internal init(id: Int, playerId: Int) {
        self.id = id
        self.playerId = playerId
        self.date = Date()
    }
    
    //MARK:- Codable >>
    
    enum CodingKeys: String, CodingKey {
        case id
        case playerId
        case date
        case passedQuestionIds
        case levelEnum
        case usedFriendHint
        case usedAuditoryHint
        case usedFiftyHint
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(playerId, forKey: .playerId)
        try container.encode(date, forKey: .date)
        try container.encode(passedQuestionIds, forKey: .passedQuestionIds)
        try container.encode(levelEnum.rawValue, forKey: .levelEnum)
        try container.encode(usedFriendHint, forKey: .usedFriendHint)
        try container.encode(usedAuditoryHint, forKey: .usedAuditoryHint)
        try container.encode(usedFiftyHint, forKey: .usedFiftyHint)
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        playerId = try container.decode(Int.self, forKey: .playerId)
        date = try container.decode(Date.self, forKey: .date)
        passedQuestionIds = try container.decode([Int].self, forKey: .passedQuestionIds)
        usedFriendHint = try container.decode(Bool.self, forKey: .usedFriendHint)
        usedAuditoryHint = try container.decode(Bool.self, forKey: .usedAuditoryHint)
        usedFiftyHint = try container.decode(Bool.self, forKey: .usedFiftyHint)
        let stringLevel = try container.decode(String.self, forKey: .levelEnum)
        self.levelEnum = LevelEnum.init(rawValue: stringLevel)!
    }
}



//MARK:- setters

extension HistoryModel {
    
    func setDate(date: Date) {
        self.date = date
    }
    
    func setPassedQuestion(questionId: Int) {
        if passedQuestionIds == nil {
            passedQuestionIds = []
        }
        passedQuestionIds?.append(questionId)
    }
    
    func setLevel(levelEnum: LevelEnum) {
        self.levelEnum = levelEnum
    }
    
    public func setUsedFriendHint(enabled: Bool) {
        usedFriendHint = enabled
    }
    
    public func setUsedAuditoryHint(enabled: Bool) {
        usedAuditoryHint = enabled
    }
    
    public func setUsedFiftyHint(enabled: Bool) {
        usedFiftyHint = enabled
    }
}


//MARK:- getters

extension HistoryModel {
    
    public func getId() -> Int {
        return id
    }
    
    public func getPlayerId() -> Int {
        return playerId
    }
    
    public func getLevel() -> LevelEnum? {
        return levelEnum
    }
    
    public func getDate() -> Date {
        return date
    }
    
    public func getPassedQuestionIds() -> [Int]? {
        return passedQuestionIds
    }
    
    public func getUsedFriendHint() -> Bool {
        return usedFriendHint
    }
    
    public func getUsedAuditoryHint() -> Bool {
        return usedAuditoryHint
    }
    
    public func getUsedFiftyHint() -> Bool {
        return usedFiftyHint
    }
}
