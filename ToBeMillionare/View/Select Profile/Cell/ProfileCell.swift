import UIKit

class ProfileCell: UICollectionViewCell {
    
    @IBOutlet weak var avaImage: AvaImage!
    
    
    func setup(id: Int, name: String, ava: URL){
        avaImage.setup(drawingImage: ava, userName: name)
    }
    
    func blink() {
        avaImage.tryBlink()
    }
    
    func blinkStop() {
        avaImage.stop()
    }
}
