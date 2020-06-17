import UIKit

class LeaderboardCell: UITableViewCell {

    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    func setup(model: LeaderboardModel){
        rankLabel.text = "\(model.getRank())"
        playerLabel.text = model.getPlayerName()
        scoreLabel.text = "\(model.getScore())"
    }
}
