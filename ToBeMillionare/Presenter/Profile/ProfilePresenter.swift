import Foundation


final class ProfilePresenter {
    
    private var vc: PresentableProfileView?
    
    private var profiles: [ProfileModel] = []
    private var selected: ProfileModel?
    
    required init(){
        profiles = RealmService.loadProfiles()
    }
    
    private func createGame(builder: GameBuilderProtocol) {
        let gamePresenter: GamePresenter = PresenterFactory.shared.getInstance()
        gamePresenter.createGame(builder: builder, profile: selected!)
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
        
        let builder: ExistingPlayerGameBuilder = ExistingPlayerGameBuilder()
        createGame(builder: builder)
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
    
    func setGameMode(modeEnum: GameModeEnum) {
        selected?.setGameMode(modeEnum: modeEnum)
    }
    
    
    func setUsePassedQuestions(enabled: Bool) {
        selected?.setUsePassedQuestions(enabled: enabled)
    }
}
