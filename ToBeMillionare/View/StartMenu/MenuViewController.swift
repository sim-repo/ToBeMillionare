
import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var logoToBeLabel: UILabel!
    @IBOutlet weak var logoIllionareLabel: UILabel!
    @IBOutlet weak var logoMView: LogoView!
    @IBOutlet weak var playView: UIView!
    
    var presenter: ViewableMenuPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPresenter()
        colorSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }

    
    private func setPresenter() {
        let p: MenuPresenter  = PresenterFactory.shared.getPresenter(viewDidLoad: self) as! MenuPresenter
        presenter = p as ViewableMenuPresenter
    }
    
    
    private func colorSetup(){
        view.backgroundColor = TBMStyleKit.mainBackground
        logoToBeLabel.textColor = TBMStyleKit.primaryTextColor
        logoIllionareLabel.textColor = TBMStyleKit.primaryTextColor
        logoMView.backgroundColor = .clear
    }
    
    private func buttonSetup(){
        playView.layer.shadowColor = UIColor.black.cgColor
        playView.layer.shadowOpacity = 1
        playView.layer.shadowOffset = .zero
        playView.layer.shadowRadius = 10
        playView.layer.shouldRasterize = true //cache the rendered shadow
    }
    
    
    @IBAction func pressPlay(_ sender: Any) {
        presenter.didPressPlay()
    }
    
    
    @IBAction func pressLeaderboard(_ sender: Any) {
        presenter.didPressLeaderboard()
    }
    
    @IBAction func pressOptions(_ sender: Any) {
        presenter.didPressOptions()
    }
}

extension MenuViewController: PresentableMenuView {
    
    func performPlaySegue() {
        performSegue(withIdentifier: "SeguePlay", sender: nil)
    }
    
    func performLeaderboardSegue() {
        performSegue(withIdentifier: "SegueLeaderboard", sender: nil)
    }
    
    func performOptionsSegue() {
        performSegue(withIdentifier: "SegueOptions", sender: nil)
    }
}
