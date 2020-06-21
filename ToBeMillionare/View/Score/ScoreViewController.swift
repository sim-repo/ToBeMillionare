import UIKit

class ScoreViewController: UIViewController {
    
    @IBOutlet weak var bottomBCQView: UIView!
    @IBOutlet weak var scoreWaveView: ScoreWaveView!
    @IBOutlet weak var scoreStarsView: ScoreStarsView!
    @IBOutlet weak var scoreRobotView: ScoreRobotView!
    @IBOutlet weak var stackView: UIStackView!
    
    private var coordinates: [Int:CGPoint] = [:]
    private var robotDelegates: [Int:RobotCompatibleProtocolDelegate] = [:]
    
    
    var presenter: ViewableScorePresenter!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        colorSetup()
        scoreWaveView.startAnimate()
        scoreStarsView.startAnimate()
        setPresenter()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }
    
    
    private func setPresenter() {
        let p: ScorePresenter  = PresenterFactory.shared.getPresenter(viewDidLoad: self) as! ScorePresenter
        presenter = p as ViewableScorePresenter
    }
    
    private func createTargetCoordinate(tag: Int, isTakeFrom: Bool = false) {
        for subviews in stackView.subviews {
            for subview2 in subviews.subviews {
                if tag == subview2.tag  { //  if 100...1000000 ~= subview2.tag
                    let toScoreCoord =  subview2.convert(subview2.frame, to: stackView)
                    let margin: CGFloat = 5
                    coordinates[subview2.tag] = CGPoint(x: stackView.frame.midX,
                                                 y: stackView.frame.origin.y + toScoreCoord.origin.y + subview2.frame.height - margin)
                    robotDelegates[subview2.tag] = subview2 as? RobotCompatibleProtocolDelegate
                    
                    if isTakeFrom {
                        (subview2 as? RobotCompatibleProtocolDelegate)?.didPut()
                    }
                }
            }
        }
    }
    
    
    private func colorSetup(){
        view.backgroundColor = TBMStyleKit.mainBackground
        bottomBCQView.backgroundColor = TBMStyleKit.lighting
        bottomBCQView.fadeView(style: .top, percentage: 1.0)
    }
    
    
    @IBAction func pressPlay(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}


//MARK:- Presentable

extension ScoreViewController: PresentableScoreView {
    
    func startAnimate(prevLevelEnum: LevelEnum, curLevelEnum: LevelEnum) {
        
        if curLevelEnum == .level1 {
            createTargetCoordinate(tag: Int(curLevelEnum.rawValue) ?? 0)
            scoreRobotView.putOnly(coordinates: coordinates, robotDelegates: robotDelegates)
        } else {
            let prevLev = prevLevelEnum.rawValue.replacingOccurrences(of: " ", with: "")
            let curLev = curLevelEnum.rawValue.replacingOccurrences(of: " ", with: "")
            createTargetCoordinate(tag: Int(prevLev) ?? 0, isTakeFrom: true)
            createTargetCoordinate(tag: Int(curLev) ?? 0)
            scoreRobotView.takeAndPut(coordinates: coordinates, robotDelegates: robotDelegates)
        }
    }
}
