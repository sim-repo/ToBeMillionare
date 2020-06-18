import UIKit
import MBCircularProgressBar

class PlayViewController: UIViewController {
    
    
    @IBOutlet weak var bottomBCQView: UIView!
    @IBOutlet weak var timerRemainingLabel: UILabel!
    @IBOutlet weak var progressbarView: MBCircularProgressBarView!
    @IBOutlet weak var moneyView: MoneyView!
    
    // questions:
    
    @IBOutlet weak var questionLeftBlockView: BlockView!
    @IBOutlet weak var questionCentralBlockView: BlockView!
    @IBOutlet weak var questionRightBlockView: BlockView!
    @IBOutlet weak var questionLabel: UILabel!
    
    // answers:
    
    @IBOutlet weak var answer1LeftBlockView: BlockView!
    @IBOutlet weak var answer1CentralBlockView: BlockView!
    @IBOutlet weak var answer1RightBlockView: BlockView!
    
    @IBOutlet weak var answer2LeftBlockView: BlockView!
    @IBOutlet weak var answer2CentralBlockView: BlockView!
    @IBOutlet weak var answer2RightBlockView: BlockView!
    
    @IBOutlet weak var answer3LeftBlockView: BlockView!
    @IBOutlet weak var answer3CentralBlockView: BlockView!
    @IBOutlet weak var answer3RightBlockView: BlockView!
    
    @IBOutlet weak var answer4LeftBlockView: BlockView!
    @IBOutlet weak var answer4CentralBlockView: BlockView!
    @IBOutlet weak var answer4RightBlockView: BlockView!
    
    
    @IBOutlet weak var answerLabel1: UILabel!
    @IBOutlet weak var answerLabel2: UILabel!
    @IBOutlet weak var answerLabel3: UILabel!
    @IBOutlet weak var answerLabel4: UILabel!
    
    
    // auditory hint:
    @IBOutlet weak var auditoryHintView: AuditoryHintChartView!
    @IBOutlet weak var auditoryHintIconView: AuditoryHintIconView!
    @IBOutlet weak var hintBackgroundViewUpCon: NSLayoutConstraint!
    @IBOutlet weak var hintBackgroundViewDownCon: NSLayoutConstraint!
    
    // fifty percent hint:
    @IBOutlet weak var fiftyPercentIconView: FiftyPercentHintIconView!
    
    // call hint:
    @IBOutlet weak var callFriendIconView: CallFriendIconView!
    
    
    var presenter: ViewablePlayPresenter!
    
    
    var timer: Timer?
    var timeLeft = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPresenter()
        colorSetup()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewDidAppear()
        timerReset()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }
    
    private func setPresenter() {
        let p: PlayPresenter  = PresenterFactory.shared.getPresenter(viewDidLoad: self) as! PlayPresenter
        presenter = p as ViewablePlayPresenter
    }
    
    
    private func colorSetup(){
        view.backgroundColor = TBMStyleKit.mainBackground
        bottomBCQView.backgroundColor = TBMStyleKit.lighting
        bottomBCQView.fadeView(style: .top, percentage: 1.0)
    }
    
    
    @IBAction func pressAnswer1(_ sender: Any) {
        stopCountdown()
        presenter.didPressSelectAnswer(selectedAnswerId: "A")
    }
    
    
    @IBAction func pressAnswer2(_ sender: Any) {
        stopCountdown()
        presenter.didPressSelectAnswer(selectedAnswerId: "B")
    }
    
    
    @IBAction func pressAnswer3(_ sender: Any) {
        stopCountdown()
        presenter.didPressSelectAnswer(selectedAnswerId: "C")
    }
    
    
    @IBAction func pressAnswer4(_ sender: Any) {
        stopCountdown()
        presenter.didPressSelectAnswer(selectedAnswerId: "D")
    }
    
    
    @IBAction func pressAuditoryHint(_ sender: Any) {
        stopCountdown()
        presenter.didPressUseAuditoryHint()
    }
    
    
    @IBAction func pressAuditoryClose(_ sender: Any) {
        hintBackgroundViewDownCon.isActive = false
        
        UIView.animate(withDuration: 1.0,
                       delay: 0.0,
                       options: [],
                       animations: {
                        self.hintBackgroundViewUpCon.isActive = true
                        self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    
    @IBAction func pressFiftyPercentHint(_ sender: Any) {
        stopCountdown()
        presenter.didPressUseFiftyHint()
    }
    
    
    @IBAction func pressCallFriendsHint(_ sender: Any) {
        stopCountdown()
        presenter.didPressUseFriendHint()
    }
    
    
    @IBAction func pressFinish(_ sender: Any) {
        presenter.didPressFinish()
    }
    
    
    private func animateOpenAnswer(left: BlockView, central: BlockView, right: BlockView, tintColorEnum: BlockView.TintColorEnum, _ completion: (()->Void)? = nil) {
        left.animateShowAnswer(tintColorEnum: tintColorEnum, completion: completion)
        central.animateShowAnswer(tintColorEnum: tintColorEnum)
        right.animateShowAnswer(tintColorEnum: tintColorEnum)
    }
    
    
    private func animateBlink(left: BlockView, central: BlockView, right: BlockView, completion: (()->Void)? = nil ) {
        left.animateBlink(completion: completion)
        central.animateBlink()
        right.animateBlink()
    }
    
    
    private func fillBlack(left: BlockView, central: BlockView, right: BlockView) {
        left.setBlackBackground()
        central.setBlackBackground()
        right.setBlackBackground()
    }
    
    private func setVisibility(left: BlockView, central: BlockView, right: BlockView, isHidden: Bool) {
        left.isHidden = isHidden
        central.isHidden = isHidden
        right.isHidden = isHidden
    }
}


//MARK:- Timer

extension PlayViewController  {
    
    private func timerReset() {
        progressbarView.value = 60
        timeLeft = 60
        timerRemainingLabel.text = "\(timeLeft)"
    }
    
    private func timerStart() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
    }
    
    @objc func onTimerFires() {
        timeLeft -= 1
        progressbarView.value -= 1
        timerRemainingLabel.text = "\(timeLeft)"
        
        if timeLeft <= 0 {
            timer?.invalidate()
            presenter.didTimeout()
        }
    }
}



//MARK:- Presentable

extension PlayViewController: PresentablePlayView {
    
    func showQuestion(question: ReadableQuestion) {
        questionLabel.text = question.getQuestionText()
        answerLabel1.text = question.getAnswers()[0].getAnswerText()
        answerLabel2.text = question.getAnswers()[1].getAnswerText()
        answerLabel3.text = question.getAnswers()[2].getAnswerText()
        answerLabel4.text = question.getAnswers()[3].getAnswerText()
        
        questionLabel.fadeIn(duration: 1.0, delay: 1.0)
        answerLabel1.fadeIn(duration: 1.0, delay: 2.0)
        answerLabel2.fadeIn(duration: 1.0, delay: 2.2)
        answerLabel3.fadeIn(duration: 1.0, delay: 2.3)
        answerLabel4.fadeIn(duration: 1.0, delay: 2.4,
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
            if vc is ViewController {
                _ = self.navigationController?.popToViewController(vc as! ViewController, animated: true)
            }
        }
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
    
    
    func showFiftyPercentHint(wrongFirstAnswerId: Int, wrongSecondAnswerId: Int) {
        
        if wrongFirstAnswerId == 1 || wrongSecondAnswerId == 1 {
            setVisibility(left: answer1LeftBlockView, central: answer1CentralBlockView, right: answer1RightBlockView, isHidden: true)
        }
        
        if wrongFirstAnswerId == 2 || wrongSecondAnswerId == 2 {
            setVisibility(left: answer2LeftBlockView, central: answer2CentralBlockView, right: answer2RightBlockView, isHidden: true)
        }
        
        if wrongFirstAnswerId == 3 || wrongSecondAnswerId == 3 {
            setVisibility(left: answer3LeftBlockView, central: answer3CentralBlockView, right: answer3RightBlockView, isHidden: true)
        }
        
        if wrongFirstAnswerId == 4 || wrongSecondAnswerId == 4 {
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


