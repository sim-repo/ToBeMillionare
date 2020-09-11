import Foundation


final class TemplateProfileModel {
    
    private var avaURLs: [URL]
    private var miniAvaURLs: [URL]
    
    internal init(avaURLs: [URL], miniAvaURLs: [URL]) {
        self.avaURLs = avaURLs
        self.miniAvaURLs = miniAvaURLs
    }
}


//MARK:- getters

extension TemplateProfileModel: ReadableTemplateProfile {
    
    func getAvaURLs() -> [URL] {
        return avaURLs
    }
    
    func getMiniAvaURLs() -> [URL] {
        return miniAvaURLs
    }
}

