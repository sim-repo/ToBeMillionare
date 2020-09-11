
import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var playView: UIView!
    @IBOutlet weak var logoRays: LogoRaysLayer!
    @IBOutlet weak var logoDust: LogoDustLayer!
    @IBOutlet weak var conButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var topButton: Curtain!
    @IBOutlet weak var middleButton: Curtain!
    @IBOutlet weak var bottomButton: Curtain!
    @IBOutlet weak var backButton: BackButton!
    @IBOutlet weak var bonusView: BonusView!
    
    // #0004
    @IBOutlet weak var miniAva: MiniAva!
    @IBOutlet weak var miniAvaImageView: UIImageView!
    @IBOutlet weak var conMiniAvaTop: NSLayoutConstraint!
    @IBOutlet weak var conMiniAvaTrailing: NSLayoutConstraint!
    @IBOutlet weak var conMiniAvaCenterY: NSLayoutConstraint!
    @IBOutlet weak var conMiniAvaCenterX: NSLayoutConstraint!
    @IBOutlet weak var ava: Ava!
    @IBOutlet weak var avaImageView: UIImageView!
    
    
    private var playPresenter: ReadablePlayPresenter {
        let presenter: PlayPresenter = PresenterFactory.shared.getInstance()
        return presenter as ReadablePlayPresenter
    }
    
    
    var mainMenuShown = true
    var presenter: ViewableMenuPresenter!
    
    enum MenuButtonEnum {
        case top, middle, bottom
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPresenter()
        //  let test = TestBonus()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupLayout()
        setupControls()
        setupMiniAva()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
        logoRays.startAnimation()
        logoDust.startAnimation()
    }
    
    
    private func setupLayout() {
        if ScreenResolutionsEnum.screen() == .screen_47 {
            conButtonHeight.constant = 40
        } else if ScreenResolutionsEnum.screen() == .screen_55 {
            conButtonHeight.constant = 50
        }
        else {
            conButtonHeight.constant = 60
        }
    }
    
    private func setupControls(){
        topButton.setup(title: getButtonText(.top))
        middleButton.setup(title: getButtonText(.middle))
        bottomButton.setup(title: getButtonText(.bottom))
    }
    
    private func setPresenter() {
        let p: MenuPresenter  = PresenterFactory.shared.getPresenter(viewDidLoad: self) as! MenuPresenter
        presenter = p as ViewableMenuPresenter
    }
    
    
    private func stopAnimation(){
        logoRays.stop()
        logoDust.stop()
    }
    
    @IBAction func pressTopButton(_ sender: Any) {
        if mainMenuShown {
            presenter.didPressPlay()
            return
        }
        performProgressSegue()
    }
    
    
    @IBAction func pressMiddleButton(_ sender: Any) {
        if mainMenuShown {
            mainMenuShown = false
            animationTopButton()
            animationMiddleButton()
            animationBottomButton()
            animationBackButton()
            return
        }
        performSpaceshipSegue()
    }
    
    @IBAction func pressBottomButton(_ sender: Any) {
        if mainMenuShown {
            presenter.didPressOptions()
            return
        }
        performAsteroidSegue()
    }
    
    
    @IBAction func pressBackMainMenu(_ sender: Any) {
        guard mainMenuShown == false else { return }
        mainMenuShown = true
        animationTopButton()
        animationMiddleButton()
        animationBottomButton()
        animationBackButton()
    }
    
    private func getButtonText(_ buttonEnum: MenuButtonEnum) -> String {
        switch buttonEnum {
        case .top:
            return mainMenuShown ? "ИГРАТЬ" : "ПРОГРЕСС"
        case .middle:
            return mainMenuShown ? "СТАТИСТИКА" : "ЗОНД"
        case .bottom:
            return mainMenuShown ? "ОПЦИИ" : "АСТЕРОЙД"
        }
    }
}

// MARK:- Button Animation
extension MenuViewController {
    
    private func animationTopButton() {
        topButton.startDisappear() { [weak self] in
            guard let self = self else { return }
            self.topButton.startAppear(title: self.getButtonText(.top))
        }
    }
    
    private func animationMiddleButton() {
        middleButton.startDisappear() { [weak self] in
            guard let self = self else { return }
            self.middleButton.startAppear(title: self.getButtonText(.middle))
        }
    }
    
    private func animationBottomButton() {
        bottomButton.startDisappear() { [weak self] in
            guard let self = self else { return }
            self.bottomButton.startAppear(title: self.getButtonText(.bottom))
        }
    }
    
    private func animationBackButton() {
        if mainMenuShown {
            backButton.startDisappear()
        } else {
            backButton.startAppear()
        }
    }
}


// MARK:- Segues
extension MenuViewController: PresentableMenuView {
    
    func performPlaySegue() {
        stopAnimation()
        performSegue(withIdentifier: "SeguePlayV2", sender: nil)
    }
    
    func performProgressSegue() {
        stopAnimation()
        performSegue(withIdentifier: "SegueProgress", sender: nil)
    }
    
    func performOptionsSegue() {
        stopAnimation()
        performSegue(withIdentifier: "SegueOptions", sender: nil)
    }
    
    func performSpaceshipSegue() {
        stopAnimation()
        performSegue(withIdentifier: "SegueSpaceship2", sender: nil)
    }
    
    func performAsteroidSegue() {
        stopAnimation()
        performSegue(withIdentifier: "SegueSolarSystem", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueSpaceship2" {
            let dest = segue.destination as! SpaceshipViewController1
            dest.setup(stage: playPresenter.getStage(), score: playPresenter.getDepo())
        }
    }
}


// MARK:- #0004
extension MenuViewController {
    
    private func setupMiniAva() {
        let url = self.presenter.getAvaURL()
        miniAvaImageView.image = UIImage(named: url.absoluteString)
        miniAva.setup(currentStage: presenter.getCurrentStage(), depo: presenter.getDepo())
    }
    
    private func conDisable(_ con: NSLayoutConstraint) {
        con.isActive = false
    }
    
    private func conEnable(_ con: NSLayoutConstraint) {
        con.isActive = true
    }
    
    
    @IBAction func pressMiniAva(_ sender: Any) {
        conDisable(conMiniAvaTop)
        conDisable(conMiniAvaTrailing)
        
        UIView.animate(withDuration: 0.3,
                       animations: { [weak self] in
                        guard let self = self else { return }
                        self.conEnable(self.conMiniAvaCenterY)
                        self.conEnable(self.conMiniAvaCenterX)
                        self.view.layoutIfNeeded()
        }) {_ in
            self.startAvaAppearance()
        }
    }
    
    private func startAvaAppearance(){
        ava.startAppearance(currencySymbol: presenter.getCurrencySymbol(),currentStage: presenter.getCurrentStage(), depo: presenter.getDepo()) {[weak self] in
            guard let self = self else { return }
            let url = self.presenter.getAvaURL()
            self.avaImageView.image = UIImage(named: url.absoluteString)
            self.avaImageView.blink()
            self.ava.tryBlink()
        }
    }
    
    
    @IBAction func pressAva(_ sender: Any) {
        avaImageView.layer.removeAllAnimations()
        avaImageView.image = nil
        avaImageView.alpha = 1
        ava.didPress() {[weak self] in
            guard let self = self else { return }
            self.returnMiniAva()
            self.ava.stop()
        }
    }
    
    
    private func returnMiniAva() {
        conDisable(conMiniAvaCenterY)
        conDisable(conMiniAvaCenterX)
        
        UIView.animate(withDuration: 0.3,
                       animations: { [weak self] in
                        guard let self = self else { return }
                        self.conEnable(self.conMiniAvaTop)
                        self.conEnable(self.conMiniAvaTrailing)
                        self.view.layoutIfNeeded()
        })
    }
}
