
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var logoToBeLabel: UILabel!
    @IBOutlet weak var logoIllionareLabel: UILabel!
    @IBOutlet weak var logoMView: LogoView!
    
    @IBOutlet weak var playView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    private func colorSetup(){
        view.backgroundColor = TBMStyleKit.mainBackground
        logoToBeLabel.textColor = TBMStyleKit.primaryTextColor
        logoIllionareLabel.textColor = TBMStyleKit.primaryTextColor
        logoMView.backgroundColor = TBMStyleKit.mainBackground
    }
    
    private func buttonSetup(){
        playView.layer.shadowColor = UIColor.black.cgColor
        playView.layer.shadowOpacity = 1
        playView.layer.shadowOffset = .zero
        playView.layer.shadowRadius = 10
        playView.layer.shouldRasterize = true //cache the rendered shadow
    }
    
    
    @IBAction func pressPlay(_ sender: Any) {
        performSegue(withIdentifier: "SeguePlay", sender: nil)
    }
    
    
    @IBAction func pressLeaderboard(_ sender: Any) {
        performSegue(withIdentifier: "SegueLeaderboard", sender: nil)
    }
    
    @IBAction func pressOptions(_ sender: Any) {
        performSegue(withIdentifier: "SegueOptions", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SeguePlay" {
            
        }
    }
}

