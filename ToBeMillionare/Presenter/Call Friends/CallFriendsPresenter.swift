import Foundation


final class CallFriendsPresenter {
    
    private var vc: PresentableCallFriendsView?
    private var questionId: Int = 0
    private var usedHint = false
    
    private var gamePresenter: ReadableGamePresenter {
        let presenter: GamePresenter = PresenterFactory.shared.getInstance()
        return presenter as ReadableGamePresenter
    }
    
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
        let questionId = playPresenter.getCurQuestionId()
        let answer = gamePresenter.getFriendAnswer(questionId: questionId, occupationEnum: occupationEnum)
        vc?.showFriendAnswer(answerId: answer.getAnswerId())
    }
}
