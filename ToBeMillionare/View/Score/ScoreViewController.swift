import UIKit

class ScoreViewController: UIViewController {
    
    @IBOutlet weak var bottomBCQView: UIView!
    @IBOutlet weak var scoreWaveView: ScoreWaveView!
    @IBOutlet weak var scoreStarsView: ScoreStarsView!
    @IBOutlet weak var scoreRobotView: ScoreRobotView!
    @IBOutlet weak var stackView: UIStackView!
    
    private var coordinates: [Int:CGPoint] = [:]
    private var robotDelegates: [Int:RobotCompatibleProtocolDelegate] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorSetup()
        scoreWaveView.startAnimate()
        scoreStarsView.startAnimate()
        
        //testRobot()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fillScoresY() // must invoked in viewDidAppear because of actual screen detected here
    }
    
    
    private func fillScoresY() {
        for subviews in stackView.subviews {
            for subview2 in subviews.subviews {
                if 100...1000000 ~= subview2.tag  {
                    let toScoreCoord =  subview2.convert(subview2.frame, to: stackView)
                    let margin: CGFloat = 5
                    coordinates[subview2.tag] = CGPoint(x: stackView.frame.midX,
                                                 y: stackView.frame.origin.y + toScoreCoord.origin.y + subview2.frame.height - margin)
                    robotDelegates[subview2.tag] = subview2 as? RobotCompatibleProtocolDelegate
                }
            }
        }
    }
    
    
    private func testRobot() {
        scoreRobotView.calibration(coordinates: coordinates, robotDelegates: robotDelegates)
    }
    
    private func colorSetup(){
        view.backgroundColor = TBMStyleKit.mainBackground
        bottomBCQView.backgroundColor = TBMStyleKit.lighting
        bottomBCQView.fadeView(style: .top, percentage: 1.0)
    }
    
    @IBAction func doPress(_ sender: Any) {
        testRobot()
    }
}
