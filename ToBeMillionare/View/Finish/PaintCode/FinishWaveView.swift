import UIKit

class FinishWaveView: UIView {
    
    
    // timer vars:
    private var globalTimer: Timer?
    private var timer: Timer?
    private var timeLeft = 20 // in ms
    private var halfTimeLeft = 10 // in ms
    private var globalTimerInterval = 2.0 // in sec
    
    // control vars:
    private var scale: CGFloat = 1
    private var starNum: Int = 1
    
    private var scaleStar1: CGFloat = 1
    private var scaleStar2: CGFloat = 1
    private var scaleStar3: CGFloat = 1
    private var scaleStar4: CGFloat = 1
    
    private var finishStrokeY: CGFloat = 519
    private var finishStrokeY2: CGFloat = 517
    
    
    override func draw(_ rect: CGRect) {
        TBMStyleKit.drawFinishWave(frame: bounds,
                                   resizing: .stretch,
                                   scaleStar1: scaleStar1,
                                   scaleStar2: scaleStar2,
                                   scaleStar3: scaleStar3,
                                   scaleStar4: scaleStar4,
                                   finishStrokeY: finishStrokeY,
                                   finishStrokeY2: finishStrokeY2)
    }
    
    
    public func startAnimate() {
        starNum = Int.random(in: 1 ... 4)
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.redraw), userInfo: nil, repeats: true)
        
        globalTimer = Timer.scheduledTimer(withTimeInterval: globalTimerInterval, repeats: true) {_ in
            self.resetTimer()
            self.starNum = Int.random(in: 1 ... 4)
            self.timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(self.redraw), userInfo: nil, repeats: true)
        }
    }
    
    
    private func resetTimer(){
        timeLeft = 20
    }
    
    private func resetValues() {
        scaleStar1 = 1
        scaleStar2 = 1
        scaleStar3 = 1
        scaleStar4 = 1
    }
    
    
    @objc private func redraw() {
        
        if halfTimeLeft... ~= timeLeft {
            scale = 0.25
        }
        
        if 0...halfTimeLeft-1 ~= timeLeft {
            scale = -0.25
        }
        
        switch starNum {
        case 1:
            scaleStar1 += scale
        case 2:
            scaleStar2 += scale
        case 3:
            scaleStar3 += scale
        case 4:
            scaleStar4 += scale
        default:
            break
        }
        if finishStrokeY < 700 {
            finishStrokeY += 0.2
        }
        
        if finishStrokeY2 > 250 {
            finishStrokeY2 -= 0.2
        }
        
        setNeedsDisplay()
        
        timeLeft -= 1
        if timeLeft <= 0 {
            resetValues()
            timer?.invalidate()
        }
    }
}
