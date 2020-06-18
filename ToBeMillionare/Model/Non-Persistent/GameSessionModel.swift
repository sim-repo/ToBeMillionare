import Foundation


final class GameSessionModel {

    private var levelEnum: LevelEnum = LevelEnum.level1
    private var usedFriendHint: Bool = false
    private var usedAuditoryHint: Bool = false
    private var usedFiftyHint: Bool = false
}

//MARK: - setters
extension GameSessionModel {
    
    public func setLevel(levelEnum: LevelEnum) {
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


//MARK: - getters
extension GameSessionModel {
    
    public func getLevel() -> LevelEnum {
        return levelEnum
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
