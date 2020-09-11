import Foundation


final class MenuPresenter {
    
    private weak var vc: PresentableMenuView?
    
    required init(){}
    
    internal var profile: ReadableProfile {
        return ProfileService.getForcedSelected()
    }
}


//MARK:- Viewable
extension MenuPresenter: ViewableMenuPresenter {

    func setView(vc: PresentableView) {
        self.vc = vc as? PresentableMenuView
    }
    
    func didPressPlay() {
        vc?.performPlaySegue()
    }
    
    func didPressLeaderboard() {
        vc?.performProgressSegue()
    }
    
    func didPressOptions() {
        vc?.performOptionsSegue()
    }
    
    func viewDidAppear() {
        PresenterFactory.shared.dismisPresenter(clazz: CallFriendsPresenter.self)
        PresenterFactory.shared.dismisPresenter(clazz: PlayPresenter.self)
    }
    
    func getAvaURL() -> URL {
        return profile.getAva()
    }
    
    func getCurrentStage() -> Int {
        return profile.getStage()
    }
    
    func getDepo() -> Double {
        return profile.getDepo()
    }
    
    func getCurrencySymbol() -> String {
        return ProfileService.getCurrencySymbol()
    }
}
