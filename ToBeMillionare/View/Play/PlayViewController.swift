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
    
    
    // next round view:
    @IBOutlet weak var nextRoundLabel: UILabel!
    @IBOutlet weak var nextRoundViewHideCon: NSLayoutConstraint!
    @IBOutlet weak var nextRoundViewShowCon: NSLayoutConstraint!
    @IBOutlet weak var nextRoundView: UIView!
    
    
    @IBOutlet weak var nextRoundBkgView: UIView!
    @IBOutlet weak var nextRoundBkgViewShowCon: NSLayoutConstraint!
    @IBOutlet weak var nextRoundBkgViewHideCon: NSLayoutConstraint!
    
    
    
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
    
    deinit {
        print("------------------DEINIT------------------")
        print("........PlayViewController................")
        print("------------------------------------------")
    }
    
    internal func setPresenter() {
        let p: PlayPresenter  = PresenterFactory.shared.getPresenter(viewDidLoad: self) as! PlayPresenter
        presenter = p as ViewablePlayPresenter
    }
    
    
    internal func colorSetup(){
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
        animateAuditoryClose()
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
    
    
    
    
    internal func fillBlack(left: BlockView, central: BlockView, right: BlockView) {
        left.setBlackBackground()
        central.setBlackBackground()
        right.setBlackBackground()
    }
    
    
    internal func setVisibility(left: BlockView, central: BlockView, right: BlockView, isHidden: Bool) {
        left.isHidden = isHidden
        central.isHidden = isHidden
        right.isHidden = isHidden
    }
}


//MARK:- Timer

extension PlayViewController  {
    
    internal func timerReset() {
        progressbarView.value = 60
        timeLeft = 60
        timerRemainingLabel.text = "\(timeLeft)"
    }
    
    internal func timerStart() {
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



