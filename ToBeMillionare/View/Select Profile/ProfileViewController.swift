import UIKit

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: ViewableProfilePresenter {
        return PresenterFactory.shared.getPresenter(viewDidLoad: self) as! ViewableProfilePresenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

//MARK:- Collection Data Source

extension ProfileViewController: UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
        
        if let profile = presenter.getData(indexPath) {
            cell.setup(id: profile.getId(), name: profile.getName(), ava: profile.getAva())
        }
        return cell
    }
}


//MARK:- Collection Data Delegate

extension ProfileViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectProfile(indexPath)
    }
}


//MARK:- Presentable

extension ProfileViewController: PresentableProfileView {
    
    func performMainSegue() {
        performSegue(withIdentifier: "SegueMenu", sender: nil)
    }
    
    
    func performNewProfileSegue() {
        performSegue(withIdentifier: "SegueCreateProfile", sender: nil)
    }
}
