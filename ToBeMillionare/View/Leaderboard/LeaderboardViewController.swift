import UIKit


class LeaderboardViewController: UIViewController {
    
    var presenter: ViewableLeaderboardPresenter {
        return PresenterFactory.shared.getPresenter(viewDidLoad: self) as! ViewableLeaderboardPresenter
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func pressBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}



extension LeaderboardViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderboardCell", for: indexPath) as! LeaderboardCell
        if let leaderboard = presenter.getData(indexPath: indexPath) {
            cell.setup(model: leaderboard)
        }
        return cell
    }
}



extension LeaderboardViewController: PresentableLeaderboardView {
    
    func reloadData() {
        tableView.reloadData()
    }
}
