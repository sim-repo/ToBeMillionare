import Foundation


final class TemplateProfileModel {
    
    private var avaURLs: [URL]
    
    internal init(avaURLs: [URL]) {
        self.avaURLs = avaURLs
    }
}


//MARK:- getters

extension TemplateProfileModel: ReadableTemplateProfile {
    
    func getAvaURLs() -> [URL] {
        return avaURLs
    }
}

