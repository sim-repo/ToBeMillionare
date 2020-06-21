import Foundation


final class ScorePresenter: PresenterProtocol {
    
    
    private var prevLevelEnum: LevelEnum?
    private var curLevelEnum: LevelEnum?
    
    private weak var vc: PresentableScoreView?
}


//MARK:- Writable
extension ScorePresenter: WritableScorePresenter {
    
    func setLevel(prevLevelEnum: LevelEnum, curLevelEnum: LevelEnum) {
        self.prevLevelEnum = prevLevelEnum
        self.curLevelEnum = curLevelEnum
    }
}

//MARK:- Viewable
extension ScorePresenter: ViewableScorePresenter {
    func setView(vc: PresentableView) {
        self.vc = vc as? PresentableScoreView
    }
    
    func viewDidAppear() {
        guard let prevLevelEnum = prevLevelEnum,
              let curLevelEnum = curLevelEnum
            else {
                //TODO err
                return }
        
        vc?.startAnimate(prevLevelEnum: prevLevelEnum, curLevelEnum: curLevelEnum)
    }
}
