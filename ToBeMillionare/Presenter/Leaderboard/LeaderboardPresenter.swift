import Foundation

final class LeaderboardPresenter {
    
    private var vc: PresentableProfileView?
    
    required init(){}
}



//MARK:- Viewable
extension LeaderboardPresenter: ViewableLeaderboardPresenter {
    
    func setView(vc: PresentableView) {
        self.vc = vc as? PresentableProfileView
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRowsInSection() -> Int {
        return 20
    }
    
    func getData(indexPath: IndexPath) -> LeaderboardModel? {
        return nil
    }
}
