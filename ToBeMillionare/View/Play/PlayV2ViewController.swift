//
//  PlayV2ViewController.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 22.07.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

class PlayV2ViewController: UIViewController {
    
    
    @IBOutlet weak var achievementImageView: UIImageView!
    
    @IBOutlet weak var counterView: PlayCounterView!
    @IBOutlet weak var conCounterHeight: NSLayoutConstraint!
    @IBOutlet weak var conQuestionHeight: NSLayoutConstraint!
    @IBOutlet weak var conQuestionBottom: NSLayoutConstraint!
    @IBOutlet weak var conCounterTop: NSLayoutConstraint!
    @IBOutlet weak var conAchievementTrailing: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var questionView: PlayQuestionView!
    @IBOutlet weak var questionTextView: UITextView!
    
    @IBOutlet weak var markerYellow: MarkerView!
    @IBOutlet weak var markerBlue: MarkerView!
    @IBOutlet weak var markerGreen: MarkerView!
    @IBOutlet weak var markerRed: MarkerView!
    
    @IBOutlet weak var finishButton: PlayOkButtonView!
    
    @IBOutlet weak var auditoryIconView: PlayHintView!
    @IBOutlet weak var percentsIconView: PlayHintView!
    @IBOutlet weak var phoneIconView: PlayHintView!
    @IBOutlet weak var conPhoneTop: NSLayoutConstraint!
    @IBOutlet weak var scoreView: PlayScoreView!
    
    @IBOutlet weak var groupButtonView: PlayGroupButtonView!
    
    @IBOutlet weak var answerButtonA: PlayButtonView!
    @IBOutlet weak var answerButtonB: PlayButtonView!
    @IBOutlet weak var answerButtonC: PlayButtonView!
    @IBOutlet weak var answerButtonD: PlayButtonView!
    
    
    // #0001
    @IBOutlet weak var dialog: PlayDialog!
    @IBOutlet weak var dialogButtonYES: PlayDialogButton!
    @IBOutlet weak var dialogButtonNO: PlayDialogButton!
    @IBOutlet weak var conDialogCenterX: NSLayoutConstraint!
    @IBOutlet weak var conDialogTrailing: NSLayoutConstraint!
    @IBOutlet weak var conDialogButtonYESLeading: NSLayoutConstraint!
    @IBOutlet weak var conDialogButtonYESLeading2: NSLayoutConstraint!
    @IBOutlet weak var conDialogButtonNOTrailing: NSLayoutConstraint!
    @IBOutlet weak var conDialogButtonNOTrailing2: NSLayoutConstraint!
    @IBOutlet weak var conDialogCoverCenterX: NSLayoutConstraint!
    @IBOutlet weak var conDialogCoverLeading: NSLayoutConstraint!
    @IBOutlet weak var notification: PlayNotification!
    @IBOutlet weak var conNotificationTrailing: NSLayoutConstraint!
    @IBOutlet weak var conNotificationCenterX: NSLayoutConstraint!
    
    
    @IBOutlet weak var nextRoundView: NextScreenView!
    
    var presenter: ViewablePlayPresenter!
    var spentTime: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPresenter()
        setupCounter()
        setupIcons()
        setupAnswerIds()
        setupScore()
        setupMarker()
        setupNextRound(enable: false)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewDidAppear()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    deinit {
        print("------------------DEINIT------------------")
        print("........PlayViewController................")
        print("------------------------------------------")
    }
    
    
    internal func setupPresenter() {
        let p: PlayPresenter  = PresenterFactory.shared.getPresenter(viewDidLoad: self) as! PlayPresenter
        presenter = p as ViewablePlayPresenter
    }
    
    
    private func setupCounter() {
        if ScreenResolutionsEnum.screen() == .screen_47 {
            conCounterHeight.constant = 70
            conPhoneTop.constant = 2
            conCounterTop.constant = 24
        } else if ScreenResolutionsEnum.screen() == .screen_55 {
            conCounterHeight.constant = 80
            conPhoneTop.constant = 4
            conCounterTop.constant = 24
        }
        else {
            conCounterHeight.constant = 90
            conPhoneTop.constant = 16
        }
    }
    
    
    private func setupMarker(){
        markerYellow.prepareBlink()
        markerBlue.prepareBlink()
        markerRed.prepareBlink()
        markerGreen.prepareBlink()
        markerYellow.tryBlink(type: .yellow, delayBlink: 5.0)
        markerBlue.tryBlink(type: .blue, delayBlink: 7.0)
        markerRed.tryBlink(type: .red, delayBlink: 8.0)
        markerGreen.tryBlink(type: .green, delayBlink: 9.0)
    }
    
    
    private func setupScore() {
        scoreView.setup(scoreAim: presenter.getStageAim(), scoreDepo: presenter.getDepo())
    }
    
    
    internal func setupNextRound(enable: Bool){
        nextRoundView.isHidden = !enable
        setupMarker()
    }
    
    
    @IBAction func pressZoom(_ sender: Any) {
        let zoomed = conQuestionHeight.constant == 150
        conQuestionHeight.constant = zoomed ? 102 : 150
        conQuestionBottom.constant = zoomed ? 43 : 91
        self.questionTextView.font = UIFont(name: SECONDARY_FRONT_FAMILY+"-Light", size: zoomed ? 15 : 18)
        UIView.animate(withDuration: 0.5, animations: {
            self.questionView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }, completion: {_ in
            self.redrawAnswers()
        })
    }
    
    
    @IBAction func pressFinish(_ sender: Any) {
        finishButton.press() { [weak self] in
            guard let self = self else { return }
            self.presenter.didPressFinish()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueAuditory" {
            guard let dest = segue.destination as? AuditoryViewController else { return }
            guard let percents = sender as? [Double] else { return }
            dest.setup(percentA: CGFloat(percents[0]), percentB: CGFloat(percents[1]), percentC: CGFloat(percents[2]), percentD: CGFloat(percents[3]))
        }
        
        if segue.identifier == "SegueNextStage" {
            guard let dest = segue.destination as? StageViewController else { return }
            guard let params = sender as? [Int] else { return }
            dest.setup(stageNum: params[0], zondRecovery: params[1], daysBeforeDisaster: params[2])
        }
    }
}


// MARK:- Hint
extension PlayV2ViewController {
    
    private func setupIcons(){
        auditoryIconView.setup(hintType: .auditory)
        phoneIconView.setup(hintType: .phone)
        percentsIconView.setup(hintType: .percent)
    }
    
    
    @IBAction func pressPercent(_ sender: Any) {
        presenter.didPressUseFiftyHint()
    }
    
    @IBAction func pressAuditory(_ sender: Any) {
        presenter.didPressUseAuditoryHint()
    }
    
    @IBAction func pressPhone(_ sender: Any) {
        presenter.didPressUseFriendHint()
    }
    
}


// MARK:- Answer
extension PlayV2ViewController {
    
    
    private func setupAnswerIds(){
        answerButtonA.setup(id: "A")
        answerButtonB.setup(id: "B")
        answerButtonC.setup(id: "C")
        answerButtonD.setup(id: "D")
    }
    
    
    @IBAction func pressAnswerA(_ sender: Any) {
        didPressAnswer(answerId: "A")
        markerYellow.didPress(type: .yellow)
        markerBlue.stop()
        markerRed.stop()
        markerGreen.stop()
    }
    
    private func redrawAnswers(){
        markerYellow.setNeedsDisplay()
        markerBlue.setNeedsDisplay()
        markerGreen.setNeedsDisplay()
        markerRed.setNeedsDisplay()
        groupButtonView.setNeedsDisplay()
        answerButtonA.setNeedsDisplay()
        answerButtonB.setNeedsDisplay()
        answerButtonC.setNeedsDisplay()
        answerButtonD.setNeedsDisplay()
    }
    
    
    @IBAction func pressAnswerB(_ sender: Any) {
        didPressAnswer(answerId: "B")
        markerBlue.didPress(type: .blue)
        markerYellow.stop()
        markerRed.stop()
        markerGreen.stop()
    }
    
    @IBAction func pressAnswerC(_ sender: Any) {
        didPressAnswer(answerId: "C")
        markerGreen.didPress(type: .green)
        markerYellow.stop()
        markerRed.stop()
        markerBlue.stop()
    }
    
    @IBAction func pressAnswerD(_ sender: Any) {
        didPressAnswer(answerId: "D")
        markerRed.didPress(type: .red)
        markerYellow.stop()
        markerGreen.stop()
        markerBlue.stop()
    }
    
    private func didPressAnswer(answerId: String) {
        presenter.didPressSelectAnswer(selectedAnswerId: answerId, spentTime: spentTime)
    }
}


// MARK:- Dialog
// #0001
extension PlayV2ViewController {
    
    @IBAction func pressDialogYES(_ sender: Any) {
        hideDialogRenewFireproof() {[weak self] in
            guard let self = self else { return }
            self.presenter.didPressDialogIsContinue(isContinue: true)
        }
    }
    
    
    @IBAction func pressDialogNO(_ sender: Any) {
        hideDialogRenewFireproof() {[weak self] in
            guard let self = self else { return }
            self.presenter.didPressDialogIsContinue(isContinue: false)
        }
    }
    
    
    private func hideDialogRenewFireproof(completion: (()->Void)? = nil) {
        conDialogCoverCenterX.isActive = false
        conDialogCenterX.isActive = false

        conDialogButtonYESLeading2.isActive = false
        conDialogButtonNOTrailing2.isActive = false
        
        UIView.animate(withDuration: 1.0,
                       animations: {
                        self.conDialogCoverLeading.isActive = true
                        self.conDialogTrailing.isActive = true
                        self.conDialogButtonYESLeading.isActive = true
                        self.conDialogButtonNOTrailing.isActive = true
                        self.view.layoutIfNeeded()
        }, completion: { _ in
            completion?()
        })
    }
}
