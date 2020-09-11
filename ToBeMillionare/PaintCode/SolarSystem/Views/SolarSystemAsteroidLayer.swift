import UIKit



class SolarSystemAsteroidLayer: UIView {
    
    // timer vars:
    private var timer: Timer?
    
    
    // control vars:
    private var pathMaskShow: CGFloat = 0.0
    private var asteroidShow: CGFloat = 0.0
    private var asteroidMove: CGFloat = 0.0

    private var targetAsteroidMove: CGFloat = 0.0
    
    
    private var completion: (()->Void)? = nil
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    
    override func draw(_ rect: CGRect) {
        if ScreenResolutionsEnum.screen() == .screen_65 {
            SolarSystemScreen.drawSolarSystemAsteroidLayer_65(frame: bounds,
                                                          solarPathMaskShow: pathMaskShow,
                                                          solarAsteroidShow: asteroidShow,
                                                          solarAsteroidMove: asteroidMove)
        } else if ScreenResolutionsEnum.screen() == .screen_58 {
            SolarSystemScreen.drawSolarSystemAsteroidLayer_58(frame: bounds,
                                                          solarPathMaskShow: pathMaskShow,
                                                          solarAsteroidShow: asteroidShow,
                                                          solarAsteroidMove: asteroidMove)
            
        } else if ScreenResolutionsEnum.screen() == .screen_55 {
            SolarSystemScreen.drawSolarSystemAsteroidLayer_55(frame: bounds,
                                                          solarPathMaskShow: pathMaskShow,
                                                          solarAsteroidShow: asteroidShow,
                                                          solarAsteroidMove: asteroidMove)
            
        } else if ScreenResolutionsEnum.screen() == .screen_47 {
            SolarSystemScreen.drawSolarSystemAsteroidLayer_47(frame: bounds,
                                                          solarPathMaskShow: pathMaskShow,
                                                          solarAsteroidShow: asteroidShow,
                                                          solarAsteroidMove: asteroidMove)
        }
        
    }
    
    public func stop() {
        timer?.invalidate()
        timer = nil
    }
    
    
    private func runOnce(timer: Timer, current: inout CGFloat, target: CGFloat, step: CGFloat, completion: (()->Void)? = nil) {
        print("SolarSystemAsteroidLayer")
        if current < target {
            current += step
        }
        
        self.setNeedsDisplay()
        
        if target...target+step ~= current {
            timer.invalidate()
            completion?()
        }
    }
    
    
    public func startPathShowAnimation(completion: (()->Void)? = nil) {
        self.completion = completion
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase1), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawPhase1(){
        guard let timer = timer else { return }
        runOnce(timer: timer, current: &pathMaskShow, target: 1.0, step: 0.04, completion: completion)
    }
    
    
    public func startAsteroidShowAnimation(completion: (()->Void)? = nil) {
        self.completion = completion
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase2), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawPhase2(){
        guard let timer = timer else { return }
        runOnce(timer: timer, current: &asteroidShow, target: 1.0, step: 0.06, completion: completion)
    }
    
    
    public func startAsteroidMoveAnimation(daysBeforeDisaster: Int, completion: (()->Void)? = nil) {
        targetAsteroidMove = 0.6 - CGFloat(daysBeforeDisaster)*0.02
        self.completion = completion
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase3), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawPhase3(){
        guard let timer = timer else { return }
        runOnce(timer: timer, current: &asteroidMove, target: targetAsteroidMove, step: 0.01, completion: completion)
    }
}

