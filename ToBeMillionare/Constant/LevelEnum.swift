import Foundation


enum LevelEnum: String, CaseIterable {
    case level1 = "100"
    case level2 = "200"
    case level3 = "500"
    case level4 = "1000"
    case level5 = "2000"
    case level6 = "4000"
    case level7 = "8000"
    case level8 = "16 000"
    case level9 = "32 000"
    case level10 = "64 000"
    case level11 = "128 000"
    case level12 = "256 000"
    case level13 = "1 000 000"
    
    static func getAward(levelEnum: LevelEnum) -> String {
        return levelEnum.rawValue
    }
}
