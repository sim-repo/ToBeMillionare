import Foundation


final class ProfileModel: Codable {
    
    private var id: Int = 0
    private var name: String
    private var age: Int
    private var ava: URL
    private var modeEnum: GameModeEnum = .easy
    private var fakeProfile = false
    
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
        case fakeProfile
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(age, forKey: .age)
        try container.encode(ava, forKey: .ava)
        try container.encode(modeEnum.rawValue, forKey: .modeEnum)
        try container.encode(fakeProfile, forKey: .fakeProfile)
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        age = try container.decode(Int.self, forKey: .age)
        ava = try container.decode(URL.self, forKey: .ava)
        fakeProfile = try container.decode(Bool.self, forKey: .fakeProfile)
        let stringMode = try container.decode(String.self, forKey: .modeEnum)
        self.modeEnum = GameModeEnum.init(rawValue: stringMode)!
    }
}


//MARK: - setters
extension ProfileModel: WriteableProfile {
    
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
}
