//
//  PlayV2ViewController+Presentable.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 23.07.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

//MARK:- Presentable

extension PlayV2ViewController: PresentablePlayView {
    
    func startCountdown() {
        counterView.start(){ [weak self] in
            guard let self = self else { return }
            self.presenter.didTimeout()
        }
    }
    
    
    func stopCountdown() {
        spentTime = counterView.stop()
    }
    
    
    func showNextRoundView(nextRoundEnum: RoundEnum) {
        setupNextRound(enable: true)
        counterView.reset()
        answerButtonA.startAnswerTextHide()
        answerButtonB.startAnswerTextHide()
        answerButtonC.startAnswerTextHide()
        answerButtonD.startAnswerTextHide()
        questionTextView.fadeOut(duration: 0.0, delay: 0)
        nextRoundView.start(nextRoundEnum: nextRoundEnum, title: "Раунд \(nextRoundEnum.rawValue)") { [weak self] in
            guard let self = self else { return }
            self.setupNextRound(enable: false)
            self.presenter.didNextRoundAnimated()
        }
    }
    
    
    func showQuestion(roundEnum: RoundEnum, question: ReadableQuestion) {
        questionTextView.text = question.getQuestionText()
        let a = question.getAnswers()[0].getAnswerText()
        let b = question.getAnswers()[1].getAnswerText()
        let c = question.getAnswers()[2].getAnswerText()
        let d = question.getAnswers()[3].getAnswerText()
        
        var qduration: TimeInterval = 0
        var qdelay: TimeInterval = 0
        var adelay: TimeInterval = 0
        
        //MARK:- Timing:
        let round = roundEnum.rawValue
        if round < 5 {
            qduration = 0.5
            qdelay = 0.5
            adelay = 0.01
        }
        
        if 5...10 ~= round {
            qduration = 1
            qdelay = 1
            adelay = 0.05
        }
        
        if 11...13 ~= round {
            qduration = 2.5
            qdelay = 1.5
            adelay = 0.05
        }
        
        
        questionTextView.fadeIn(duration: qduration, delay: qdelay,
                                completion: { [weak self] (finished: Bool) -> Void in
                                    guard let self = self else { return }
                                    self.answerButtonA.startAnswerTextShow(answerText: a, delay: adelay) { [weak self] in
                                        guard let self = self else { return }
                                        self.answerButtonB.startAnswerTextShow(answerText: b, delay: adelay) { [weak self] in
                                            guard let self = self else { return }
                                            self.answerButtonC.startAnswerTextShow(answerText: c, delay: adelay) { [weak self] in
                                                guard let self = self else { return }
                                                self.answerButtonD.startAnswerTextShow(answerText: d, delay: adelay) { [weak self] in
                                                    guard let self = self else { return }
                                                    self.startCountdown()
                                                    self.presenter.didShownAllQuestions()
                                                }
                                            }
                                        }
                                    }
        })
    }
    
    
    func performSegueStat() {
        performSegue(withIdentifier: "SegueStat2", sender: nil)
    }
    
    
    func gotoMainMenu(deepness: Int) {
        for _ in 0...deepness-1 {
            dismiss(animated: false, completion: nil)
        }
    }
    
    
    func showAuditoryHint(fractionA: Double, fractionB: Double, fractionC: Double, fractionD: Double) {
        auditoryIconView.startAnimate() { [weak self] in
            guard let self = self else { return }
            let fractions: [Double] = [fractionA, fractionB, fractionC, fractionD]
            self.performSegue(withIdentifier: "SegueAuditory", sender: fractions)
        }
    }
    
    
    func showFiftyHint(wrongFirstAnswerId: String, wrongSecondAnswerId: String) {
        percentsIconView.startAnimate()
        if wrongFirstAnswerId == "A" || wrongSecondAnswerId == "A" {
            answerButtonA.startAnswerTextHide()
        }
        
        if wrongFirstAnswerId == "B" || wrongSecondAnswerId == "B" {
            answerButtonB.startAnswerTextHide()
        }
        
        if wrongFirstAnswerId == "C" || wrongSecondAnswerId == "C" {
            answerButtonC.startAnswerTextHide()
        }
        
        if wrongFirstAnswerId == "D" || wrongSecondAnswerId == "D" {
            answerButtonD.startAnswerTextHide()
        }
    }
    
    
    func performSegueCallFriend() {
        phoneIconView.startAnimate() { [weak self] in
            self?.performSegue(withIdentifier: "SegueCallFriends", sender: nil)
        }
    }
    
    
    func showGameOver() {
        performSegue(withIdentifier: "SegueGameOver", sender: nil)
    }
    
    
    func showSuccess(nextRoundEnum: RoundEnum, roundAward: Int, fireproofRemaining: Int, _ completion: (()->Void)?) {
        scoreView.startAward(nextRoundEnum: nextRoundEnum, scoreAward: roundAward, scoreFireproofRem: fireproofRemaining, completion: completion)
    }
    
    
    func openTrueAnswer(_ roundEnum: RoundEnum, _ selectedAnswerId: String, _ rightAnswerId: String, _ completion: (() -> Void)?) {
        switch selectedAnswerId {
        case "A":
            answerButtonA.startOpenTrue(id: rightAnswerId, roundEnum, completion)
        case "B":
            answerButtonB.startOpenTrue(id: rightAnswerId, roundEnum, completion)
        case "C":
            answerButtonC.startOpenTrue(id: rightAnswerId, roundEnum, completion)
        case "D":
            answerButtonD.startOpenTrue(id: rightAnswerId, roundEnum, completion)
        default:
            break
        }
    }
    
    
    func blur(enabled: Bool) {
        let blurEffectView:UIVisualEffectView = UIVisualEffectView()
        UIView.animate(withDuration: 3.5) {
            blurEffectView.effect = UIBlurEffect(style: .dark)
            self.view.addSubview(blurEffectView)
            blurEffectView.frame = self.view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }
    
    
    func showAchievement(achievementEnum: AchievementEnum) {
        
        achievementImageView.image = UIImage(named: achievementEnum.rawValue)
        
        UIView.animateKeyframes(withDuration: 4.0, delay: 0, options: .calculationModeLinear, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/3) {
                self.conAchievementTrailing.constant = -92
                self.view.layoutIfNeeded()
            }
            
            UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3) {
                
            }
            
            UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3) {
                self.conAchievementTrailing.constant = 0
                self.view.layoutIfNeeded()
            }
        }, completion: nil)
    }
    
    
    func performSegueNextStage(stageNum: Int, zondRecovery: Int, daysBeforeDisaster: Int) {
        performSegue(withIdentifier: "SegueNextStage", sender: [stageNum, zondRecovery, daysBeforeDisaster])
    }
    
    // #0001
    func showDialogRenewFireproof(title: String, desc: String) {
        
        dialogButtonYES.setup(title: "YES")
        dialogButtonNO.setup(title: "NO")
        
        conDialogButtonYESLeading.isActive = false
        conDialogButtonNOTrailing.isActive = false
        
        conDialogCoverLeading.isActive = false
        conDialogTrailing.isActive = false
        dialog.setup(title: title, desc: desc)
        
        
        UIView.animate(withDuration: 1.0,
                       animations: {
                        self.conDialogCoverCenterX.isActive = true
                        self.conDialogCenterX.isActive = true
                        self.conDialogButtonYESLeading2.isActive = true
                        self.conDialogButtonNOTrailing2.isActive = true
                        self.view.layoutIfNeeded()
        })
    }
    
    // #0001
    func showNotification(text: String) {
        conNotificationTrailing.isActive = false
        notification.setup(text: text)
        UIView.animateKeyframes(withDuration: 3.0,
                                delay: 0,
                                options: .calculationModeLinear,
                                animations: {
                                    UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.1, animations: {
                                        self.conNotificationCenterX.isActive = true
                                        self.view.layoutIfNeeded()
                                    })
                                    
                                    UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.8, animations: {
                                            self.conNotificationCenterX.isActive = false
                                    })
                                    
                                    UIView.addKeyframe(withRelativeStartTime: 0.9, relativeDuration: 0.02, animations: {
                                        self.conNotificationTrailing.isActive = true
                                        self.view.layoutIfNeeded()
                                    })
                                },
                                completion: nil)
    }
}
