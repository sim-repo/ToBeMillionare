import UIKit



class SolarSystemHoloLayer: UIView {
    
    // timer vars:
    private var timer: Timer?
    
    
    // control vars:
    private var holoPlanetsShow: CGFloat = 0.0
    private var holoPlanetsHide: CGFloat = 0.0
    
    
    // operations:
    private var phase1: (()->Void)?
    private var phase2: (()->Void)?
    

    
    private var completion: (()->Void)? = nil
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    
    override func draw(_ rect: CGRect) {
        
        SolarSystemScreen.drawSolarSystemHoloLayer(frame: bounds,
                                                  solarHoloPlanetsShow: holoPlanetsShow,
                                                  solarHoloPlanetsHide: holoPlanetsHide)
    }
    
    
    private func runOnce(timer: Timer, current: inout CGFloat, target: CGFloat, step: CGFloat, completion: (()->Void)? = nil) {
        print("SolarSystemHoloLayer")
        if current < target {
            current += step
        }
        
        self.setNeedsDisplay()
        
        if target...target+step ~= current {
            timer.invalidate()
            completion?()
        }
    }
    
    public func stop() {
        timer?.invalidate()
        timer = nil
    }
    
    public func startHoloPlanetsShowAnimation(completion: (()->Void)? = nil) {
        self.completion = completion
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase1), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase1(){
        guard let timer = timer else { return }
        runOnce(timer: timer, current: &holoPlanetsShow, target: 1.0, step: 0.06, completion: completion)
    }
    
    
    public func startHoloPlanetsHideAnimation(completion: (()->Void)? = nil) {
        self.completion = completion
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase2), userInfo: nil, repeats: true)
    }

    
    @objc private func redrawPhase2(){
        guard let timer = timer else { return }
        runOnce(timer: timer, current: &holoPlanetsHide, target: 1.0, step: 0.06, completion: completion)
    }
}
