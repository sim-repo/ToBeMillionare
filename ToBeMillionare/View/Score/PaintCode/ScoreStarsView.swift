import UIKit



class ScoreStarsView: UIView {
    

    
    // timer vars:
    private var globalTimer: Timer?
    private var timer: Timer?
    private var timeLeft = 10 // in ms
    private var halfTimeLeft = 5 // in ms
    private var globalTimerInterval = 4.0 // in sec
    
    // control vars:
    private var scale: CGFloat = 1
    private var starNum: Int = 1
    
    private var scaleStar1: CGFloat = 1
    private var scaleStar2: CGFloat = 1
    private var scaleStar3: CGFloat = 1
    private var scaleStar4: CGFloat = 1
    
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        TBMStyleKit.drawStars(frame: bounds,
                              resizing: .aspectFit,
                              scaleStar1: scaleStar1,
                              scaleStar2: scaleStar2,
                              scaleStar3: scaleStar3,
                              scaleStar4: scaleStar4)
    }
    
    
    
    public func startAnimate() {
        starNum = Int.random(in: 1 ... 4)
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.redraw), userInfo: nil, repeats: true)
        
        globalTimer = Timer.scheduledTimer(withTimeInterval: globalTimerInterval, repeats: true) {_ in
            self.resetTimer()
            self.starNum = Int.random(in: 1 ... 4)
            self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.redraw), userInfo: nil, repeats: true)
        }
    }
    
    
    private func resetTimer(){
        timeLeft = 10
    }
    
    private func resetValues() {
        scaleStar1 = 1
        scaleStar2 = 1
        scaleStar3 = 1
        scaleStar4 = 1
    }
    
    @objc private func redraw() {
        
        
        
        if halfTimeLeft... ~= timeLeft {
            scale = 1
        }
        
        if 0...halfTimeLeft-1 ~= timeLeft {
            scale = -1
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
        setNeedsDisplay()
        
        timeLeft -= 1
        if timeLeft <= 0 {
            resetValues()
            timer?.invalidate()
        }
    }
}
