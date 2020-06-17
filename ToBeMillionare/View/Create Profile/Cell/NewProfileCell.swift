import UIKit

class NewProfileCell: UICollectionViewCell {
    
    @IBOutlet weak var avaImageView: UIImageView!
    
    func setup(ava: URL) {
        avaImageView.image = UIImage(named: ava.absoluteString)
    }
}
