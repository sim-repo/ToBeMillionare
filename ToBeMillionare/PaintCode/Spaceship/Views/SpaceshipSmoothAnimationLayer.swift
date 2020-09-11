import UIKit

class SpaceshipSmoothAnimationLayer: UIView {
    
    
    enum Direction {
        case plus, minus
    }
    
    // timer vars:
    private var timer: Timer?
    private var subTimer: Timer?
    private var currentSmoothAnimation = 0
    private var stage: Int = 0
    
    // control vars:
    private var discPathsSmoothAnimation: CGFloat = 0.0
    private var circlesLightMoveY: CGFloat = 1.0
    private var circlesLightMoveX: CGFloat = 1.0
    
    private var circlesLightDirection: Direction = .plus
    private var discPathfinderDirection: Direction = .plus
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    
    override func draw(_ rect: CGRect) {
        SpaceshipScreen.drawSpaceshipDiscreteAnimationLayer2(
            frame: bounds,
            resizing: .aspectFit,
            circlesMove: circlesLightMoveY,
            circlesLight: circlesLightMoveX,
            discPathsSmoothAnimation: discPathsSmoothAnimation,
            discPathOpacityOffset: 0.3)
    }
    
    
    public func stop() {
        timer?.invalidate()
        timer = nil
        subTimer?.invalidate()
        subTimer = nil
    }
    
    private func runOnce(timer: Timer, direction: Direction = .plus, current: inout CGFloat, step: CGFloat, nextAnimationNum: inout Int) {
        
        if direction == .plus {
            if current < 1.0 {
                current += step
            }
        } else {
            if current > 0.0 {
                current -= step
            }
        }
        
        self.setNeedsDisplay()
        
        if direction == .plus {
            if 1.0-step...1.0+step ~= current {
                timer.invalidate()
            }
        } else {
            if 0.0-step...0.0+step ~= current {
                timer.invalidate()
            }
        }
    }
}


extension SpaceshipSmoothAnimationLayer {
    
    public func startAnimation(stage: Int) {
        self.stage = stage
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.redrawTimer), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawTimer(){
        
        if currentSmoothAnimation >= 1 {
            currentSmoothAnimation = 0
        } else {
            currentSmoothAnimation += 1
        }
        
        subTimer?.invalidate()
        
        switch currentSmoothAnimation {
        case 0:
            if stage == 8 {
                circlesLightDirection = circlesLightDirection == .plus ? .minus : .plus
                circlesLightMoveX = circlesLightDirection == .plus ? 0 : 1
            }
        case 1:
            discPathfinderDirection = discPathfinderDirection == .plus ? .minus : .plus
            discPathsSmoothAnimation = discPathfinderDirection == .plus ? 0 : 1
        default:
            break
        }
        subTimer = Timer.scheduledTimer(timeInterval: 0.04, target: self, selector: #selector(self.subRedrawTimer), userInfo: nil, repeats: true)
    }
    
    
    @objc private func subRedrawTimer(){
        guard let timer = subTimer else { return }
        
        switch currentSmoothAnimation {
        case 0:
            if stage == 8 {
                runOnce(timer: timer, direction: circlesLightDirection, current: &circlesLightMoveX, step: 0.01, nextAnimationNum: &currentSmoothAnimation)
            }
        case 1:
            runOnce(timer: timer, direction: discPathfinderDirection, current: &discPathsSmoothAnimation, step: 0.01, nextAnimationNum: &currentSmoothAnimation)
        default:
            break
        }
    }
}





