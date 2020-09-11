import UIKit



class SolarSystemView: UIView {
    
    // timer vars:
    private var timer: Timer?
    
    
    private var completion: (()->Void)? = nil
    
    // control vars:
    private var dottedCoverHide: CGFloat = 0.0
    private var solarSunShow1: CGFloat = 0.0
    private var solarSunShow2: CGFloat = 0.0
    
    // operations:
    //          phase1:
    private var phase1: (()->Void)?
    private var phase2: (()->Void)?
    private var phase3: (()->Void)?
   
    private var sequence: [(()->Void)?] = []
    private var currOperationNum = -1
    

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    override func draw(_ rect: CGRect) {
        
        SolarSystemScreen.drawSolarSystemSunLayer(frame: bounds,
                                                solarDottedCoverHide: dottedCoverHide,
                                                solarSunShow1: solarSunShow1,
                                                solarSunShow2: solarSunShow2)
    }
    
    
    private func gotoSequence(){
        if sequence.count - 1 > currOperationNum {
            currOperationNum += 1
            let operation = sequence[currOperationNum]
            operation?()
        } else {
            completion?()
        }
    }
    
    
    private func runOnce(timer: Timer, current: inout CGFloat, target: CGFloat, step: CGFloat, completion: (()->Void)? = nil) {
        print("SolarSystemView")
        if current < target {
            current += step
        }
        
        self.setNeedsDisplay()
        
        if target...target+step ~= current {
            timer.invalidate()
            completion?()
            gotoSequence()
        }
    }
    
    
    public func stop() {
        timer?.invalidate()
        timer = nil
    }
    
    public func startBeginningAnimation(completion: (()->Void)? = nil) {
        phase1 = { [weak self] in self?.startPhase1() }
        phase2 = { [weak self] in self?.startPhase2() }
        
        sequence.append(phase1)
        sequence.append(phase2)
        
        self.completion = completion
        gotoSequence()
    }
    
    
    private func startPhase1() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase1), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase1(){
        guard let timer = timer else { return }
        runOnce(timer: timer, current: &dottedCoverHide, target: 1.0, step: 0.06)
    }
    
    private func startPhase2() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase2), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase2(){
        guard let timer = timer else { return }
        runOnce(timer: timer, current: &solarSunShow1, target: 1.0, step: 0.03)
    }
    
    
    
    public func startSunAnimation(completion: (()->Void)? = nil) {
        
        self.completion = completion
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase3), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawPhase3(){
        guard let timer = timer else { return }
        runOnce(timer: timer, current: &solarSunShow2, target: 1.0, step: 0.3, completion: completion)
    }
    
}
