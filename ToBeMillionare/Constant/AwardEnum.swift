import Foundation


enum AwardImageEnum: String, CaseIterable {
    case level4 = "award-1"
    case level5 = "award-2"
    case level6 = "award-4"
    case level7 = "award-8"
    case level8 = "award-16"
    case level9 = "award-32"
    case level10 = "award-64"
    case level11 = "award-128"
    case level12 = "award-256"
    case level13 = "award-1000"
    
    static func getAwardImage(levelEnum: AwardImageEnum) -> String {
        return levelEnum.rawValue
    }
}
    

