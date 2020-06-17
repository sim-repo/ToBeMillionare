import UIKit


class FiftyPercentHintIconView: UIView {
    
    
    // timer vars:
    private var timer: Timer?
    
    
    // control vars:
    private var scale: CGFloat = 1.0
    private var opacity: CGFloat = 1.0
    private var degree: Double = 0.0
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        TBMStyleKit.drawFiftyPercent(frame: bounds, resizing: .aspectFit, fiftyPercentHintIconScale: scale, fiftyPercentHintOpacity: opacity)
    }
    
    func startAnimate() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawIcon), userInfo: nil, repeats: true)
    }
    
    
    private func getFraction() -> Double {
        return sin(degree * Double.pi / 180)
    }
    
    
    @objc private func redrawIcon(){
        
        if degree < 405 {
            degree += 2
        }
        scale = CGFloat(abs(getFraction()))
        
        
        if degree >= 405 {
            timer?.invalidate()
            opacity = 0.5
        }
        self.setNeedsDisplay()
    }
}
