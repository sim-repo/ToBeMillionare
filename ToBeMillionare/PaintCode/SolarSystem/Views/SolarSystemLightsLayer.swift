import UIKit



class SolarSystemLightsLayer: UIView {
    
    // timer vars:
    private var timer: Timer?
    private var subtimer: Timer?
    
    
    // control vars:
    private var solarLightsShow: CGFloat = 0.0
    private var solarLightsBlink: CGFloat = 0.0
    
    private var smoothAnimationDirection: Direction = .plus
    
    // phases:
    private var phase1: (()->Void)?
    private var phase2: (()->Void)?
    
    
    private var sequence: [(()->Void)?] = []
    private var currOperationNum = -1
    
    enum Direction {
        case plus, minus
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    
    override func draw(_ rect: CGRect) {
        SolarSystemScreen.drawSolarSystemLightsLayer(frame: bounds,
                                                    solarLightsShow: solarLightsShow,
                                                    solarLightsBlink: solarLightsBlink)
    }
    
    
    private func gotoSequence(){
        if sequence.count - 1 > currOperationNum {
            currOperationNum += 1
            let operation = sequence[currOperationNum]
            operation?()
        }
    }
    
    
    public func stop() {
        timer?.invalidate()
        timer = nil
        subtimer?.invalidate()
        subtimer = nil
    }
    
    private func runOnce(timer: Timer, direction: Direction = .plus, current: inout CGFloat, step: CGFloat, completion: (()->Void)? = nil) {
        
        print("SolarSystemLightsLayer")
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
                completion?()
            }
        } else {
            if 0.0-step...0.0+step ~= current {
                timer.invalidate()
                completion?()
            }
        }
    }
    
    
    public func startLightsShowAnimation() {

        phase1 = { [weak self] in self?.startPhase1() }
        phase2 = { [weak self] in self?.startPhase2() }
        
        sequence.append(phase1)
        sequence.append(phase2)
        gotoSequence()
    }
    
    
    @objc private func startPhase1(){
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase1), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawPhase1(){
        guard let timer = timer else { return }
        let completion: (()->Void)? = { [weak self] in
            guard let self = self else { return }
            self.gotoSequence() }
        runOnce(timer: timer, direction: .plus, current: &solarLightsShow, step: 0.06, completion: completion)
    }
    
    
    public func startPhase2() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(self.redrawPhase2), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase2(){
        subtimer?.invalidate()
        smoothAnimationDirection = smoothAnimationDirection == .plus ? .minus : .plus
        subtimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(self.subRedrawPhase2), userInfo: nil, repeats: true)
    }
    
    
    @objc private func subRedrawPhase2(){
        guard let timer = subtimer else { return }
        runOnce(timer: timer, direction: smoothAnimationDirection, current: &solarLightsBlink, step: 0.04)
    }
}


