import UIKit

class CallFriendsViewController: UIViewController {

    
    @IBOutlet weak var answerHistorianLabel: UILabel!
    @IBOutlet weak var answerPartyGoerLabel: UILabel!
    @IBOutlet weak var answerMathematicianLabel: UILabel!
    
    @IBOutlet weak var okButton: UIButton!
    
    var presenter: ViewableCallFriendsPresenter!
    var curFriend: OccupationEnum?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPresenter()
        setupAnswers()
        okButton.alpha = 0.0
    }
    
    
    private func setPresenter() {
        let p: CallFriendsPresenter  = PresenterFactory.shared.getPresenter(viewDidLoad: self) as! CallFriendsPresenter
        presenter = p as ViewableCallFriendsPresenter
    }
    
    
    private func setupAnswers(){
        answerHistorianLabel.text = ""
        answerPartyGoerLabel.text = ""
        answerMathematicianLabel.text = ""
    }
    
    @IBAction func pressHistorian(_ sender: Any) {
        curFriend = .historian
        presenter.didSelectFriend(occupationEnum: .historian)
    }
    
    
    @IBAction func pressPartyGoer(_ sender: Any) {
        curFriend = .partyGoer
        presenter.didSelectFriend(occupationEnum: .partyGoer)
    }
    
    
    @IBAction func pressMathematician(_ sender: Any) {
        curFriend = .mathematician
        presenter.didSelectFriend(occupationEnum: .mathematician)
    }
    
    
    @IBAction func pressOk(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}



//MARK:- Presentable

extension CallFriendsViewController: PresentableCallFriendsView {
    
    func showFriendAnswer(answerId: String) {
        switch curFriend {
        case .historian:
            answerHistorianLabel.text = answerId
        case .partyGoer:
             answerPartyGoerLabel.text = answerId
        case .mathematician:
             answerMathematicianLabel.text = answerId
        default:
            break
        }
        okButton.fadeIn()
    }
}
