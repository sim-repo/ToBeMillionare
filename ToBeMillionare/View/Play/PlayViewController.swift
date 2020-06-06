import UIKit
import MBCircularProgressBar

class PlayViewController: UIViewController {

    @IBOutlet weak var bottomBCQView: UIView!
    @IBOutlet weak var timerRemainingLabel: UILabel!
    @IBOutlet weak var progressbarView: MBCircularProgressBarView!
    
    var timer: Timer?
    var timeLeft = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorSetup()
        
        timerSetup()
    }
    
    private func colorSetup(){
        view.backgroundColor = TBMStyleKit.mainBackground
        bottomBCQView.backgroundColor = TBMStyleKit.lighting
        bottomBCQView.fadeView(style: .top, percentage: 1.0)
    }
    
 
    @IBAction func pressButton(_ sender: Any) {
        performSegue(withIdentifier: "SegueScore", sender: nil)
    }
    
    
    private func timerSetup() {
        progressbarView.value = 60
        timeLeft = 60
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
        
    }
    
    
    
    @objc func onTimerFires() {
        timeLeft -= 1
        progressbarView.value -= 1
        timerRemainingLabel.text = "\(timeLeft)"

        if timeLeft <= 0 {
            timer?.invalidate()
            timer = nil
        }
    }
}
