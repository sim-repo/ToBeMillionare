//
//  ScoreRobotView.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 07.06.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

class ScoreRobotView: UIView {

    // timer vars:
    private var timer: Timer?

    
    // control vars:
    var robotHeight: CGFloat = 667
    var robotHeightStep: CGFloat = 2
    var robotArmLen: CGFloat = 20
    var robotArmStep: CGFloat = 2
    var robotTake: CGFloat = 24
    var robotTakeStep: CGFloat = 1
    var isTook = true
    
    
    var maxCanvasHeight: CGFloat = 667
    var maxCanvasWidth: CGFloat = 375
    var localTargetY: CGFloat = 0
    var localTargetX: CGFloat = 0
    var currY: CGFloat = 0
    
    
    var coordinates: [Int: CGPoint] = [:]
    var robotDelegates: [Int: RobotCompatibleProtocolDelegate] = [:]
    var scoreCount = 0
    var currIdx = 0
    var sorted: [Dictionary<Int, CGPoint>.Keys.Element] = []
    
    // hand anatomy
    var fingersLen: CGFloat = 32
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        TBMStyleKit.drawRobot(frame: bounds,
                              resizing: .stretch,
                              robotHeight: robotHeight,
                              robotTake: robotTake,
                              robotReachOut: robotArmLen)
    }

    

    public func startAnimate(point: CGPoint) {
        let screenSize = UIScreen.main.bounds
        let screenHeight = screenSize.height
        let ratioY = screenHeight / maxCanvasHeight // 1.34333
        localTargetY = point.y / ratioY
        let screenWidth = screenSize.width
        let ratioX = screenWidth / maxCanvasWidth // 1.34333
        localTargetX = point.x / ratioX - fingersLen
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawHeight), userInfo: nil, repeats: true)
    }
    
    
    public func calibration(coordinates: [Int: CGPoint], robotDelegates: [Int: RobotCompatibleProtocolDelegate]){
        self.coordinates = coordinates
        self.robotDelegates = robotDelegates
        scoreCount = coordinates.count
        //let key = Array(coordinates)[0].key
        sorted = coordinates.keys.sorted(by: {$0 < $1})
        let key = sorted[0]
        startAnimate(point: self.coordinates[key]!)
    }
}


//MARK: - hand up/down

extension ScoreRobotView {
    
    @objc private func redrawHeight(){
        
        if robotHeight < localTargetY {
            robotHeight += robotHeightStep
        }
        
        if robotHeight > localTargetY {
            robotHeight -= robotHeightStep
        }
        
        self.setNeedsDisplay()
        
        if localTargetY-robotHeightStep...localTargetY+robotHeightStep ~= robotHeight {
            timer?.invalidate()
            startAnimateReachOut()
        }
    }
}



//MARK: - hand right/left

extension ScoreRobotView {
    
    private func startAnimateReachOut() {
        let filename = "robot-sound3"
        playSound(filename: filename)
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawReachOut), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawReachOut(){
        
        if robotArmLen < localTargetX {
            robotArmLen += robotArmStep
        }
        
        self.setNeedsDisplay()
        
        if robotArmLen >= localTargetX {
            timer?.invalidate()
            if isTook {
                startAnimatePut()
            } else {
                startAnimateTake()
            }
        }
    }
    
    private func startAnimateHideHand() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawHideHand), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawHideHand(){
        
        if robotArmLen >= 20 {
            robotArmLen -= robotArmStep
        }
        
        self.setNeedsDisplay()
        
        if robotArmLen < 20 {
            timer?.invalidate()
            // calibration mode only:
            if currIdx < coordinates.count - 1 {
               // currIdx += 1
                let key = sorted[currIdx]
                startAnimate(point: coordinates[key]!)
            } else {
                coordinates.removeAll()
            }
        }
    }
}



//MARK: - hand take/put

extension ScoreRobotView {
    
    private func startAnimateTake() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawTake), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawTake(){
        
        if robotTake > 24 {
            robotTake -= robotTakeStep
        }
        
        self.setNeedsDisplay()
        
        if robotTake <= 24 {
            isTook = true
            
            let key = sorted[currIdx]
            currIdx += 1
            robotDelegates[key]?.didTake()
            timer?.invalidate()
            startAnimateHideHand()
        }
    }
    
    
    private func startAnimatePut() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPut), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawPut(){
        
        if robotTake < 30 {
            robotTake += robotTakeStep
        }
        
        self.setNeedsDisplay()
        
        if robotTake >= 30 {
            isTook = false
            
            let key = sorted[currIdx]
            robotDelegates[key]?.didPut()
            timer?.invalidate()
            startAnimateHideHand()
        }
    }
}
