import Foundation


enum LevelEnum: Int, CaseIterable {
    case level1 = 100
    case level2 = 200
    case level3 = 500
    case level4 = 1000
    case level5 = 2000
    case level6 = 4000
    case level7 = 8000
    case level8 = 16000
    case level9 = 32000
    case level10 = 64000
    case level11 = 128000
    case level12 = 256000
    case level13 = 1000000
    
    static func getAward(levelEnum: LevelEnum) -> Int {
        return levelEnum.rawValue
    }
}
    
extension CaseIterable where Self: Equatable {

    var index: Self.AllCases.Index? {
        return Self.allCases.firstIndex { self == $0 }
    }
    
}
