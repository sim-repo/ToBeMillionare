import UIKit

class ProfileCell: UICollectionViewCell {
    
    @IBOutlet weak var avaImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    func setup(id: Int, name: String, ava: URL){
        nameLabel.text = name
        avaImageView.image = UIImage(named: ava.absoluteString)
    }
    

}
