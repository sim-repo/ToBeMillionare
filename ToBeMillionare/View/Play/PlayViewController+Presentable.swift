//
//  PlayViewController + Presentable.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 21.06.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit



//MARK:- Presentable

extension PlayViewController: PresentablePlayView {
    
    func showQuestion(question: ReadableQuestion) {
        questionLabel.text = question.getQuestionText()
        answerLabel1.text = question.getAnswers()[0].getAnswerText()
        answerLabel2.text = question.getAnswers()[1].getAnswerText()
        answerLabel3.text = question.getAnswers()[2].getAnswerText()
        answerLabel4.text = question.getAnswers()[3].getAnswerText()
        
        questionLabel.fadeIn(duration: 1.0, delay: 1.5)
        answerLabel1.fadeIn(duration: 1.0, delay: 2.5)
        answerLabel2.fadeIn(duration: 1.0, delay: 2.7)
        answerLabel3.fadeIn(duration: 1.0, delay: 2.9)
        answerLabel4.fadeIn(duration: 1.0, delay: 3.1,
                            completion: { (finished: Bool) -> Void in
                                self.startCountdown()
        })
    }
    
    
    func perfomFinishSegue() {
        performSegue(withIdentifier: "SegueFinish", sender: nil)
    }
    
    
    func performScoreSegue() {
        performSegue(withIdentifier: "SegueScore", sender: nil)
    }
    
    func performCallFriendSegue(){
        callFriendIconView.startAnimate() { [weak self] in
            self?.performSegue(withIdentifier: "SegueCallFriends", sender: nil)
        }
    }
    
    func gotoMainMenu() {
        let controllers = self.navigationController?.viewControllers
        for vc in controllers! {
            if vc is MenuViewController {
                _ = self.navigationController?.popToViewController(vc as! MenuViewController, animated: true)
            }
        }
    }
    
    func showNextLevelView(levelEnum: LevelEnum) {
        nextRoundLabel.text = levelEnum.rawValue
        animateNextRound()
    }
    
    func showGameOver() {
        performSegue(withIdentifier: "SegueGameOver", sender: nil)
    }
    
    
    func showSuccess(levelEnum: LevelEnum, _ completion: (()->Void)? = nil) {
        moneyView.startAnimate(levelEnum, completion)
    }
    
    
    func openTrueAnswer(_ rightAnswerId: String, _ completion: (()->Void)? = nil ) {
        switch rightAnswerId {
        case "A":
            animateOpenAnswer(left: answer1LeftBlockView, central: answer1CentralBlockView, right: answer1RightBlockView, tintColorEnum: .green, completion)
            animateOpenAnswer(left: answer2LeftBlockView, central: answer2CentralBlockView, right: answer2RightBlockView, tintColorEnum: .red)
            animateOpenAnswer(left: answer3LeftBlockView, central: answer3CentralBlockView, right: answer3RightBlockView, tintColorEnum: .red)
            animateOpenAnswer(left: answer4LeftBlockView, central: answer4CentralBlockView, right: answer4RightBlockView, tintColorEnum: .red)
        case "B":
            animateOpenAnswer(left: answer1LeftBlockView, central: answer1CentralBlockView, right: answer1RightBlockView, tintColorEnum: .red, completion)
            animateOpenAnswer(left: answer2LeftBlockView, central: answer2CentralBlockView, right: answer2RightBlockView, tintColorEnum: .green)
            animateOpenAnswer(left: answer3LeftBlockView, central: answer3CentralBlockView, right: answer3RightBlockView, tintColorEnum: .red)
            animateOpenAnswer(left: answer4LeftBlockView, central: answer4CentralBlockView, right: answer4RightBlockView, tintColorEnum: .red)
        case "C":
            animateOpenAnswer(left: answer1LeftBlockView, central: answer1CentralBlockView, right: answer1RightBlockView, tintColorEnum: .red, completion)
            animateOpenAnswer(left: answer2LeftBlockView, central: answer2CentralBlockView, right: answer2RightBlockView, tintColorEnum: .red)
            animateOpenAnswer(left: answer3LeftBlockView, central: answer3CentralBlockView, right: answer3RightBlockView, tintColorEnum: .green)
            animateOpenAnswer(left: answer4LeftBlockView, central: answer4CentralBlockView, right: answer4RightBlockView, tintColorEnum: .red)
        case "D":
            animateOpenAnswer(left: answer1LeftBlockView, central: answer1CentralBlockView, right: answer1RightBlockView, tintColorEnum: .red, completion)
            animateOpenAnswer(left: answer2LeftBlockView, central: answer2CentralBlockView, right: answer2RightBlockView, tintColorEnum: .red)
            animateOpenAnswer(left: answer3LeftBlockView, central: answer3CentralBlockView, right: answer3RightBlockView, tintColorEnum: .red)
            animateOpenAnswer(left: answer4LeftBlockView, central: answer4CentralBlockView, right: answer4RightBlockView, tintColorEnum: .green)
        default:
            break
        }
    }
    
    
    func startBlinkAnimation(_ selectedAnswerId: String, _ completion: (()->Void)? = nil ) {
        switch selectedAnswerId {
        case "A":
            animateBlink(left: answer1LeftBlockView, central: answer1CentralBlockView, right: answer1RightBlockView, completion: completion)
        case "B":
            animateBlink(left: answer2LeftBlockView, central: answer2CentralBlockView, right: answer2RightBlockView, completion: completion)
        case "C":
            animateBlink(left: answer3LeftBlockView, central: answer3CentralBlockView, right: answer3RightBlockView, completion: completion)
        case "D":
            animateBlink(left: answer4LeftBlockView, central: answer4CentralBlockView, right: answer4RightBlockView, completion: completion)
        default: break
        }
    }
    
    
    func prepareForNextLevel() {
        fillBlack(left: questionLeftBlockView, central: questionCentralBlockView, right: questionRightBlockView)
        fillBlack(left: answer1LeftBlockView, central: answer1CentralBlockView, right: answer1RightBlockView)
        fillBlack(left: answer2LeftBlockView, central: answer2CentralBlockView, right: answer2RightBlockView)
        fillBlack(left: answer3LeftBlockView, central: answer3CentralBlockView, right: answer3RightBlockView)
        fillBlack(left: answer4LeftBlockView, central: answer4CentralBlockView, right: answer4RightBlockView)
        
        questionLabel.alpha = 0
        answerLabel1.alpha = 0
        answerLabel2.alpha = 0
        answerLabel3.alpha = 0
        answerLabel4.alpha = 0
        
        setVisibility(left: answer1LeftBlockView, central: answer1CentralBlockView, right: answer1RightBlockView, isHidden: false)
        setVisibility(left: answer2LeftBlockView, central: answer2CentralBlockView, right: answer2RightBlockView, isHidden: false)
        setVisibility(left: answer3LeftBlockView, central: answer3CentralBlockView, right: answer3RightBlockView, isHidden: false)
        setVisibility(left: answer4LeftBlockView, central: answer4CentralBlockView, right: answer4RightBlockView, isHidden: false)
    }
    
    
    func startCountdown() {
        timerReset()
        timerStart()
    }
    
    
    func stopCountdown() {
        timer?.invalidate()
    }
    
    
    func showAuditoryHint(fractionA: Double, fractionB: Double, fractionC: Double, fractionD: Double) {
        
        auditoryHintIconView.startAnimate() { [weak self] in
            guard let self = self else { return }
            
            self.hintBackgroundViewUpCon.isActive = false
            
            UIView.animate(withDuration: 1.0,
                           delay: 0.0,
                           options: [],
                           animations: {
                            self.hintBackgroundViewDownCon.isActive = true
                            self.view.layoutIfNeeded()
            }, completion: {_ in
                self.auditoryHintView.startAnimate(fractionPercentA: CGFloat(fractionA), fractionPercentB: CGFloat(fractionB), fractionPercentC: CGFloat(fractionC), fractionPercentD: CGFloat(fractionD))
            })
        }
    }
    
    
    func showFiftyPercentHint(wrongFirstAnswerId: String, wrongSecondAnswerId: String) {
        
        if wrongFirstAnswerId == "A" || wrongSecondAnswerId == "A" {
            setVisibility(left: answer1LeftBlockView, central: answer1CentralBlockView, right: answer1RightBlockView, isHidden: true)
        }
        
        if wrongFirstAnswerId == "B" || wrongSecondAnswerId == "B" {
            setVisibility(left: answer2LeftBlockView, central: answer2CentralBlockView, right: answer2RightBlockView, isHidden: true)
        }
        
        if wrongFirstAnswerId == "C" || wrongSecondAnswerId == "C" {
            setVisibility(left: answer3LeftBlockView, central: answer3CentralBlockView, right: answer3RightBlockView, isHidden: true)
        }
        
        if wrongFirstAnswerId == "D" || wrongSecondAnswerId == "D" {
            setVisibility(left: answer4LeftBlockView, central: answer4CentralBlockView, right: answer4RightBlockView, isHidden: true)
        }
        fiftyPercentIconView.startAnimate()
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
}

