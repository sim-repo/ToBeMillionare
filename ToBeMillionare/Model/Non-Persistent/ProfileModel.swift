import Foundation


final class ProfileModel {
    
    private var id: Int = 0
    private var name: String
    private var age: Int
    private var ava: URL
    private var usePassedQuestions = false
    private var modeEnum: GameModeEnum = .easy
    private var fakeProfile = false
    
    internal init(name: String, fakeProfile: Bool, age: Int, ava: URL) {
        self.name = name
        self.fakeProfile = fakeProfile
        self.age = age
        self.ava = ava
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
    
    func setUsePassedQuestions(enabled: Bool) {
        self.usePassedQuestions = enabled
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
    
    func getUsePassedQuestions() -> Bool {
        return usePassedQuestions
    }
}
