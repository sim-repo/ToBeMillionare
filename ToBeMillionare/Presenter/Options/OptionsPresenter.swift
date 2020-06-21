import Foundation


final class OptionsPresenter {
    
    private var profilePresenter: ReadableProfilePresenter & WritableProfilePresenter {
        let profilePresenter: ProfilePresenter = PresenterFactory.shared.getInstance()
        return profilePresenter
    }
    
    private weak var vc: PresentableOptionsView?
    
    required init() {}
}


//MARK:- Viewable 
extension OptionsPresenter: ViewableOptionsPresenter {
    
    func setView(vc: PresentableView) {
        self.vc = vc as? PresentableOptionsView
        let gameMode = profilePresenter.getSelected().getGameMode()
        self.vc?.setGameMode(modeEnum: gameMode)
    }
    
    
    func getSelectMode() -> GameModeEnum {
        return profilePresenter.getSelected().getGameMode()
    }
    
    
    func didSelectMode(modeEnum: GameModeEnum) {
        profilePresenter.setGameMode(modeEnum: modeEnum)
    }
}
