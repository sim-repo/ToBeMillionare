import Foundation


final class ProfilePresenter {
    
    private var vc: PresentableProfileView?
    
    //#0004:
    private var avaBlinkIdx: Int = 0
    private var timer: Timer?
    
    
    
    required init(){}
    
    private func getProfiles() -> [ProfileModel] {
        return ProfileService.getProfiles()
    }
    
    private func getSelectedProfile() -> ProfileModel? {
        return ProfileService.getSelected()
    }
}


//MARK:- Viewable
extension ProfilePresenter: ViewableProfilePresenter {
    
    func viewDidAppear() {
        startBlink()
    }
    
    
    func setView(vc: PresentableView) {
        self.vc = vc as? PresentableProfileView
    }
    
    
    func numberOfRowsInSection() -> Int {
        return getProfiles().count
    }
    
    
    func getData(_ indexPath: IndexPath) -> ReadableProfile? {
        return getProfiles()[indexPath.row]
    }
    
    func isSelected(_ indexPath: IndexPath) -> Bool {
        guard let selected = getSelectedProfile() else { return false }
        let profile = getProfiles()[indexPath.row]
        return profile.getId() == selected.getId()
    }
    
    
    func didSelectProfile(_ indexPath: IndexPath) {
        ProfileService.setSelected(row: indexPath.row)
        
        if getSelectedProfile()!.isFakeProfile() {
            vc?.performNewProfileSegue()
            return
        }
        vc?.performMainSegue()
    }
    
    func didDeselectProfile(_ indexPath: IndexPath) {
        ProfileService.deselect()
    }
    
   
    
    //#0004
    func startBlink() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.restartBlink), userInfo: nil, repeats: true)
    }
    
    //#0004
    @objc private func restartBlink() {
       avaBlinkIdx += 1
       if avaBlinkIdx == numberOfRowsInSection() {
           avaBlinkIdx = 0
       }
       vc?.blink(itemIdx: avaBlinkIdx)
    }
}


//MARK:- Readable
extension ProfilePresenter: ReadableProfilePresenter {
    
    func getSelected() -> ReadableProfile {
        return getSelectedProfile()!
    }
}



//MARK:- Optionable
extension ProfilePresenter: OptionableProfilePresenter {
    func setGameMode(modeEnum: GameModeEnum) {
        getSelectedProfile()?.setGameMode(modeEnum: modeEnum)
    }
}



