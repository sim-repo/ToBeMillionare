import Foundation


final class MenuPresenter {
    
    private var vc: PresentableMenuView?
    
    required init(){}
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
        vc?.performLeaderboardSegue()
    }
    
    func didPressOptions() {
        vc?.performOptionsSegue()
    }
}
