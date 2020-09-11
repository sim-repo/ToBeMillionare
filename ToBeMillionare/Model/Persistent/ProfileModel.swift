import Foundation


final class ProfileModel: Codable {
    
    private var id: Int = 0
    private var name: String
    private var age: Int
    private var ava: URL
    private var modeEnum: GameModeEnum = .easy
    private var fakeProfile = false
    private var achievementsEnum: [AchievementEnum] = []
    private var depo: Double = 100
    private var dateCreation: Date = Date()
    private var stage: Int = 1
    private var usedTipRenewFireproof: Bool = false // #0001, #0002
    
    internal init(name: String, fakeProfile: Bool, age: Int, ava: URL) {
        self.name = name
        self.fakeProfile = fakeProfile
        self.age = age
        self.ava = ava
    }
    
    internal init(id: Int, name: String, fakeProfile: Bool, age: Int, ava: URL) {
        self.id = id
        self.name = name
        self.fakeProfile = fakeProfile
        self.age = age
        self.ava = ava
    }
    

    //MARK:- Codable >>
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case age
        case ava
        case modeEnum
        case achievementsEnum
        case retension
        case fakeProfile
        case dateCreation
        case depo
        case stage
        case usedTipRenewFireproof
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(age, forKey: .age)
        try container.encode(ava, forKey: .ava)
        try container.encode(modeEnum.rawValue, forKey: .modeEnum)
        try container.encode(fakeProfile, forKey: .fakeProfile)
        try container.encode(dateCreation, forKey: .dateCreation)
        try container.encode(depo, forKey: .depo)
        var achievementArray: [String] = []
        for achievement in achievementsEnum {
            achievementArray.append(achievement.rawValue)
        }
        try container.encode(achievementArray, forKey: .achievementsEnum)
        try container.encode(stage, forKey: .stage)
        try container.encode(usedTipRenewFireproof, forKey: .usedTipRenewFireproof)
    }
    
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        age = try container.decode(Int.self, forKey: .age)
        ava = try container.decode(URL.self, forKey: .ava)
        fakeProfile = try container.decode(Bool.self, forKey: .fakeProfile)
        dateCreation = try container.decode(Date.self, forKey: .dateCreation)
        depo = try container.decode(Double.self, forKey: .depo)
        let stringMode = try container.decode(String.self, forKey: .modeEnum)
        self.modeEnum = GameModeEnum.init(rawValue: stringMode)!
        stage = try container.decode(Int.self, forKey: .stage)
        usedTipRenewFireproof = try container.decode(Bool.self, forKey: .usedTipRenewFireproof)
        
        // achivements:
        var achievementArray: [String] = []
        achievementArray = try container.decode([String].self, forKey: .achievementsEnum)
        for achievement in achievementArray {
            if let achievementEnum = AchievementEnum.init(rawValue: achievement) {
                achievementsEnum.append(achievementEnum)
            }
        }
    }
}


//MARK: - setters
extension ProfileModel {
    
    func setId(id: Int) {
        self.id = id
    }
    
    func setAva(ava: URL) {
        self.ava = ava
    }
    
    func setAge(age: Int) {
        self.age = age
    }
    
    func setName(name: String) {
        self.name = name
    }
    
    func setGameMode(modeEnum: GameModeEnum) {
        self.modeEnum = modeEnum
    }
    
    func setAchievement(achievementEnum: AchievementEnum) {
        achievementsEnum.append(achievementEnum)
    }
    
    func setDepo(depo: Double) {
        self.depo = depo
    }

    func setNextStage() {
        self.stage += 1
    }
    
    func setUsedTipRenewFireproof() {
        usedTipRenewFireproof = true
    }
}


//MARK: - getters
extension ProfileModel: ReadableProfile {
    
    func getId() -> Int {
        return id
    }
    
    func getName() -> String {
        return name
    }
    
    func getAge() -> Int {
        return age
    }
    
    func getAva() -> URL {
        return ava
    }
    
    func isFakeProfile() -> Bool {
        return fakeProfile
    }
    
    func getGameMode() -> GameModeEnum {
        return modeEnum
    }
    
    func getAchievementEnums() -> [AchievementEnum] {
        return achievementsEnum
    }
    
    func getDepo() -> Double {
        return depo
    }
    
    func getDateCreate() -> Date {
        return dateCreation
    }
    
    func getStage() -> Int {
        return stage
    }
    
    func getDaysBeforeDisaster() -> Int {
        let days = daysBetweenDates(startDate: getDateCreate(), endDate: Date())
        return 30 - days
    }
    
    func getUsedTipRenewFireproof() -> Bool {
        return usedTipRenewFireproof
    }
}
