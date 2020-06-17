import Foundation


final class OptionsPresenter {
    
    private var profilePresenter: ReadableProfilePresenter & WritableProfilePresenter {
        let profilePresenter: ProfilePresenter = PresenterFactory.shared.getInstance()
        return profilePresenter
    }
    
    private var vc: PresentableOptionsView?
    
    required init() {}
}


//MARK:- Viewable 
extension OptionsPresenter: ViewableOptionsPresenter {
    
    func setView(vc: PresentableView) {
        self.vc = vc as? PresentableOptionsView
        let gameMode = profilePresenter.getSelected().getGameMode()
        self.vc?.setGameMode(modeEnum: gameMode)
        let usePassedQuestions = profilePresenter.getSelected().getUsePassedQuestions()
        self.vc?.setUsePassedQuestions(enabled: usePassedQuestions)
    }
    
    
    func getSelectMode() -> GameModeEnum {
        return profilePresenter.getSelected().getGameMode()
    }
    
    func getUsePassedQuestions() -> Bool {
        return profilePresenter.getSelected().getUsePassedQuestions()
    }
    
    
    func didSelectMode(modeEnum: GameModeEnum) {
        profilePresenter.setGameMode(modeEnum: modeEnum)
    }
    
    
    func didSetUsePassedQuestions(enabled: Bool) {
        profilePresenter.setUsePassedQuestions(enabled: enabled)
    }
}
