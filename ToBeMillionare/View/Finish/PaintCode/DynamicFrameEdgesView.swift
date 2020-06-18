import UIKit

class DynamicFrameEdgesView: UIView {
    
    
    // timer vars:
    private var timer: Timer?
    
    // control vars:
    var fraction: CGFloat = 0.0
    
    
    override func draw(_ rect: CGRect) {
        TBMStyleKit.drawDynamicFrameEdges(frame: bounds,
                                          resizing: .stretch,
                                          dynamicFrameFraction: fraction)
    }
    
    
    public func startAnimate() {
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(self.redraw), userInfo: nil, repeats: true)
    }
    
    
    
    @objc private func redraw() {
        
        if fraction <= 1 {
            fraction += 0.0001
        }
        
        setNeedsDisplay()
        
        if fraction >= 1 {
            timer?.invalidate()
        }
    }
}

