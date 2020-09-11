import Foundation


final class ScorePresenter: PresenterProtocol {
    
    
    private var prevRoundEnum: RoundEnum?
    private var curRoundEnum: RoundEnum?
    
    private weak var vc: PresentableScoreView?
}


//MARK:- Writable
extension ScorePresenter: WritableScorePresenter {
    func setRound(prevRoundEnum: RoundEnum, curRoundEnum: RoundEnum) {
        self.prevRoundEnum = prevRoundEnum
        self.curRoundEnum = curRoundEnum
    }
}

//MARK:- Viewable
extension ScorePresenter: ViewableScorePresenter {
    func setView(vc: PresentableView) {
        self.vc = vc as? PresentableScoreView
    }
    
    func viewDidAppear() {
        guard let prevRoundEnum = prevRoundEnum,
              let curRoundEnum = curRoundEnum
            else {
                //TODO err
                return }
        
        vc?.startAnimate(prevRoundEnum: prevRoundEnum, curRoundEnum: curRoundEnum)
    }
}
