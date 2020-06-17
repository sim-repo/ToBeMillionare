import Foundation


protocol GameBuilderProtocol: class {
    
    func build(_ profile: ReadableProfile) -> GameModel
}
