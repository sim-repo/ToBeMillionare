import Foundation

class PlayerModel {

    var name: String
    var level: Int = 0
    var usedFriendHelping: Bool = false
    var usedHallHelping: Bool = false
    var usedFiftyPercent: Bool = false
    
    init(name: String) {
        self.name = name
    }
}
