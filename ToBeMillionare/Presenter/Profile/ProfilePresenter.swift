import Foundation


final class ProfilePresenter {
    
    private var vc: PresentableProfileView?
    
    private var profiles: [ProfileModel] = []
    private var selected: ProfileModel?
    
    required init(){
        profiles = ProfileService.loadProfiles()
    }
}


//MARK:- Viewable
extension ProfilePresenter: ViewableProfilePresenter {
    
    
    func setView(vc: PresentableView) {
        self.vc = vc as? PresentableProfileView
    }
    
    
    func numberOfRowsInSection() -> Int {
        return profiles.count
    }
    
    
    func getData(_ indexPath: IndexPath) -> ReadableProfile? {
        return profiles[indexPath.row]
    }
    
    func isSelected(_ indexPath: IndexPath) -> Bool {
        guard let selected = selected else { return false }
        let profile = profiles[indexPath.row]
        return profile.getId() == selected.getId()
    }
    
    
    func didSelectProfile(_ indexPath: IndexPath) {
        selected = profiles[indexPath.row]

        if selected!.isFakeProfile() {
            vc?.performNewProfileSegue()
            return
        }
        vc?.performMainSegue()
    }
    
    func didDeselectProfile(_ indexPath: IndexPath) {
        selected = nil
    }

}


//MARK:- Readable
extension ProfilePresenter: ReadableProfilePresenter {
    
    func getSelected() -> ReadableProfile {
        return selected!
    }
}


//MARK:- Writable
extension ProfilePresenter: WritableProfilePresenter {
    
    func setCreatedProfile(created: ProfileModel) {
        selected = created
        profiles.append(created)
    }
    
    func setGameMode(modeEnum: GameModeEnum) {
        selected?.setGameMode(modeEnum: modeEnum)
    }
}
