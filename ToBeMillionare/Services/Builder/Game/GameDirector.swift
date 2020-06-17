import Foundation

final class GameDirector {
    
    private var builder: GameBuilderProtocol
    
    init(builder: GameBuilderProtocol) {
        self.builder = builder
    }
    
    func changeBuilder(builder: GameBuilderProtocol) {
        self.builder = builder
    }
    
    func make(profile: ReadableProfile) -> GameModel {
        return builder.build(profile)
    }
}
