import UIKit


class LogoBackground: UIView {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        LogoScreen.drawBackgroundLayer(frame: bounds)
    }
    
}

