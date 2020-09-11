import Foundation


final class PlayPresenter {
    
    internal weak var vc: PresentablePlayView?
    internal var sessionService: GameSessionService!
    
    internal var scorePresenter: WritableScorePresenter {
        let presenter: ScorePresenter = PresenterFactory.shared.getInstance()
        return presenter as WritableScorePresenter
    }
    
    //session vars:
    private var usedNotification: Bool = false
    
    //round scope vars:
    internal var curQuestion: ReadableQuestion!
    internal var isAnswerButtonReady: Bool = true
    
    
    //session cache vars:
    internal var tmpOldDepo: Double = 0
    internal var tmpAward: Double = 0
    
    
    init(){
        sessionService = GameSessionService()
        sessionService.setup()
    }
}


//MARK:- 

extension PlayPresenter {
    
    
    internal func showQuestion() {
        curQuestion = sessionService.getQuestion(curRound: sessionService.getRound())
        vc?.showQuestion(roundEnum: sessionService.getRound(), question: curQuestion)
    }
    
    
    internal func getFireproofRemain() -> Int {
        let prevRound = sessionService.getPassedRound().rawValue
        let fireproofRound = getFireproofRound(tmpOldDepo)
        return fireproofRound - prevRound
    }
    
    
    private func checkAchievements() {
        if let speed = self.sessionService.calcSpeed() {
            self.vc?.showAchievement(achievementEnum: speed)
            self.sessionService.didShownAchievement(achievementEnum: speed)
            return
        }
        
        if let degree = self.sessionService.calcDegree() {
            self.vc?.showAchievement(achievementEnum: degree)
            self.sessionService.didShownAchievement(achievementEnum: degree)
            return
        }
        
        if let retention = self.sessionService.calcRetension() {
            self.vc?.showAchievement(achievementEnum: retention)
            self.sessionService.didShownAchievement(achievementEnum: retention)
            return
        }
    }
    
    
    internal func tryNextRound(spentTime: Int) {
        sessionService.didPassRound()
        sessionService.metricSaveToCache(spentTime: spentTime)
        
        if sessionService.isWinGame() {
            forceFinish()
            return
        }
        // #0001, #0002
        if sessionService.canRenewFireproof() {
            if usedTipRenewFireproof() {
                return
            }
            if usedNotification == false {
                usedNotification = true
                vc?.showNotification(text: "Отлично, цель достигнута!")
            }
        }
        goNextRound()
    }
    
    
    private func usedTipRenewFireproof() -> Bool {
        if sessionService.usedTipRenewFireproof() == false {
            sessionService.didUsedTipRenewFireproof()
            vc?.showDialogRenewFireproof(title: "Следующий раунд?", desc: "За каждый следующий вопрос сумма выигрыша удваивается 💰💰,\nно ответив неверно - вы теряете всю ставку.🔥\nЗавершить и забрать сумму можно всегда нажав на 🏁")
            return true
        }
        return false
    }
    
    
    internal func goNextRound() {
        sessionService.setNextRound()
        let nextRound = sessionService.getRound()
        self.vc?.showSuccess(nextRoundEnum: nextRound, roundAward: getDividedRoundAward(), fireproofRemaining: getFireproofRemain()){ [weak self] in
            guard let self = self else { return }
            self.checkAchievements()
            self.vc?.showNextRoundView(nextRoundEnum: nextRound)
        }
    }
    
    
    internal func finish() {
        sessionService.setFinishSession()
        if getAward() > 0 {
            if sessionService.isNextStage() {
                vc?.performSegueNextStage(stageNum: sessionService.getStage(), zondRecovery: getZondRecovery(), daysBeforeDisaster: sessionService.getDaysBeforeDisaster())
                return
            } else {
                vc?.performSegueStat()
            }
        } else {
            vc?.blur(enabled: true)
            vc?.showGameOver()
        }
    }
    
    
    internal func forceFinish() {
        sessionService.setFinishSession()
        if sessionService.isNextStage() {
            vc?.performSegueNextStage(stageNum: sessionService.getStage(), zondRecovery: getZondRecovery(), daysBeforeDisaster: sessionService.getDaysBeforeDisaster())
            return
        }
        vc?.performSegueStat()
    }
    
    
    internal func timeout() {
        sessionService.setFinishSession()
        vc?.blur(enabled: true)
        vc?.showGameOver()
    }
}

