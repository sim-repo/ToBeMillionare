import UIKit

class CallFriendsViewController: UIViewController {

    
    @IBOutlet weak var historianImageView: UIImageView!
    @IBOutlet weak var historianLabel: UILabel!
    
    @IBOutlet weak var geographerLabel: UILabel!
    @IBOutlet weak var geographerImageView: UIImageView!
    
    @IBOutlet weak var mathematicianLabel: UILabel!
    @IBOutlet weak var mathematicianImageView: UIImageView!
    
    @IBOutlet weak var litterateurLabel: UILabel!
    @IBOutlet weak var litterateurImageView: UIImageView!
    
    @IBOutlet weak var biologistLabel: UILabel!
    @IBOutlet weak var biologistImageView: UIImageView!
    
    
    @IBOutlet weak var housewifeLabel: UILabel!
    @IBOutlet weak var housewifeImageView: UIImageView!
    
    @IBOutlet weak var sportReviewerLabel: UILabel!
    @IBOutlet weak var sportReviewerImageView: UIImageView!
    
    @IBOutlet weak var eruditeLabel: UILabel!
    @IBOutlet weak var eruditeImageView: UIImageView!
    
    @IBOutlet weak var okButton: UIButton!
    
    
    @IBOutlet weak var stackView: UIStackView!
    
    
    @IBOutlet weak var questionLabel: UILabel!
    
    var presenter: ViewableCallFriendsPresenter!
    var curFriend: OccupationEnum?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPresenter()
        setupOutlets()
        okButton.alpha = 0.0
    }
    
    
    deinit {
        print("------------------DEINIT------------------")
        print("........CallFriendsViewController................")
        print("------------------------------------------")
    }
    
    private func setPresenter() {
        let p: CallFriendsPresenter  = PresenterFactory.shared.getPresenter(viewDidLoad: self) as! CallFriendsPresenter
        presenter = p as ViewableCallFriendsPresenter
    }
    
    private func setupOutlets() {
        historianLabel.text = "  "+OccupationEnum.historian.rawValue
        geographerLabel.text = "  "+OccupationEnum.geographer.rawValue
        mathematicianLabel.text = "  "+OccupationEnum.mathematician.rawValue
        litterateurLabel.text = "  "+OccupationEnum.litterateur.rawValue
        biologistLabel.text = "  "+OccupationEnum.biologist.rawValue
        housewifeLabel.text = "  "+OccupationEnum.housewife.rawValue
        sportReviewerLabel.text = "  "+OccupationEnum.sportReviewer.rawValue
        eruditeLabel.text = "  "+OccupationEnum.erudite.rawValue
        questionLabel.text = "  "+presenter.getQuestion()
    }
    
    private func didSelect(ava: UIImageView, label: UILabel) {
        ava.blink()
        label.blink()
        presenter.didSelectFriend(occupationEnum: curFriend!)
    }
   
    
    @IBAction func pressHistorian(_ sender: Any) {
        curFriend = .historian
        didSelect(ava: historianImageView, label: historianLabel)
    }
    
    
    @IBAction func pressGeographer(_ sender: Any) {
        curFriend = .biologist
        didSelect(ava: biologistImageView, label: biologistLabel)
    }
    
    
    @IBAction func pressMathematician(_ sender: Any) {
        curFriend = .mathematician
        didSelect(ava: mathematicianImageView, label: mathematicianLabel)
    }
    
    
    @IBAction func pressLitterateur(_ sender: Any) {
        curFriend = .litterateur
        didSelect(ava: litterateurImageView, label: litterateurLabel)
    }
    
    
    @IBAction func pressBiologist(_ sender: Any) {
        curFriend = .biologist
        didSelect(ava: biologistImageView, label: biologistLabel)
    }
    

    @IBAction func pressHousewife(_ sender: Any) {
        curFriend = .housewife
        didSelect(ava: housewifeImageView, label: housewifeLabel)
    }
    
    
    @IBAction func pressSportReviewer(_ sender: Any) {
        curFriend = .sportReviewer
        didSelect(ava: sportReviewerImageView, label: sportReviewerLabel)
    }
    
    
    @IBAction func pressErudite(_ sender: Any) {
        curFriend = .erudite
        didSelect(ava: eruditeImageView, label: eruditeLabel)
    }
    
    
    @IBAction func pressOk(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    private func animate() {
        UIView.animate(withDuration: 0.5, animations: {
            self.stackView.spacing = 26
        }) {_ in
            UIView.animate(withDuration: 0.5, animations: {
                       self.stackView.spacing = 8
                   })
        }
    }
}



//MARK:- Presentable

extension CallFriendsViewController: PresentableCallFriendsView {
    
    func showFriendAnswer(answerId: String) {
        animate()
        okButton.setTitle(answerId, for: .normal)
        okButton.fadeIn()
    }
}
