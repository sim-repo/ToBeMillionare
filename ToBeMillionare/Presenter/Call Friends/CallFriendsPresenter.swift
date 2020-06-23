import Foundation


final class CallFriendsPresenter {
    
    private weak var vc: PresentableCallFriendsView?
    private var usedHint = false
    
    
    private var playPresenter: ReadablePlayPresenter {
        let presenter: PlayPresenter = PresenterFactory.shared.getInstance()
        return presenter as ReadablePlayPresenter
    }
}


//MARK:- Viewable
extension CallFriendsPresenter: ViewableCallFriendsPresenter {
    
    func setView(vc: PresentableView) {
        self.vc = vc as? PresentableCallFriendsView
    }
    
    func didSelectFriend(occupationEnum: OccupationEnum) {
        guard usedHint == false else { return }
        usedHint = true
        let answer = playPresenter.getFriendAnswer(occupationEnum: occupationEnum)
        vc?.showFriendAnswer(answerId: answer.getAnswerId())
    }
    
    func getQuestion() -> String {
        return playPresenter.getQuestion()
    }
}
