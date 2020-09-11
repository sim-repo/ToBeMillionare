import Foundation


final class CreateProfilePresenter {
    
    private var vc: PresentableCreateProfileView?
    
    private var playerName: String?
    private var playerAge: Int = 0
    private var playerAva: URL?
    
    private var template: TemplateProfileModel
    
    required init(){
        template = RealmService.loadProfileTemplate()
    }
}


//MARK:- Viewable
extension CreateProfilePresenter: ViewableCreateProfilePresenter {
    
    func numberOfRowsInSection() -> Int {
        return template.getAvaURLs().count
    }
    
    
    func getData(_ indexPath: IndexPath) -> URL {
        return template.getAvaURLs()[indexPath.row]
    }
    
    
    func setView(vc: PresentableView) {
        self.vc = vc as? PresentableCreateProfileView
    }
    
    
    func didInputName(name: String) {
        playerName = name
    }

    
    func didInputAge(age: Int) {
        playerAge = age
    }
    
    
    func isSelected(_ indexPath: IndexPath) -> Bool {
        guard let playerAva = playerAva else { return false }
        let ava = template.getAvaURLs()[indexPath.row]
        return ava.absoluteString == playerAva.absoluteString
    }
    
    
    func didSelectAva(_ indexPath: IndexPath) {
        playerAva = template.getAvaURLs()[indexPath.row]
    }
    
    
    func didDeselectAva(_ indexPath: IndexPath) {
        playerAva = nil
    }
    
    
    func didSubmitProfile() {
        
        guard playerName != nil,
              playerName!.isEmpty == false
        else {
            vc?.alertNameIsEmpty()
            return
        }
        
        guard playerAge != 0
        else {
            vc?.alertAgeIsEmpty()
            return
        }
        
        guard playerAva != nil
        else {
            vc?.alertAvaIsEmpty()
            return
        }
            
        let created = ProfileModel(name: playerName!, fakeProfile: false, age: playerAge, ava: playerAva!)
        
        ProfileService.saveNewProfile(created: created)
        
        vc?.performMenuSegue()
    }
    
    
    func didCancel() {
        vc?.performProfileSegue()
    }
}
