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
    var robotHeightStep: CGFloat = 4
    var robotArmLen: CGFloat = 20
    var robotArmStep: CGFloat = 4
    var robotTake: CGFloat = 30
    var robotTakeStep: CGFloat = 4
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
    
    
    // operations:
    var upAndDown: (()->Void)?
    var reachout: (()->Void)?
    var hide: (()->Void)?
    var put: (()->Void)?
    var take: (()->Void)?
    
    var sequence: [(()->Void)?] = []
    var currOperationNum = 0
    
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
        setupOperations()
    }
    
    
    
    override func draw(_ rect: CGRect) {
        TBMStyleKit.drawRobot(frame: bounds,
                              resizing: .stretch,
                              robotHeight: robotHeight,
                              robotTake: robotTake,
                              robotReachOut: robotArmLen)
    }
    
    
    private func setupOperations(){
        
        upAndDown = { [weak self] in
            guard let self = self else { return }
            let key = self.sorted[self.currIdx]
            self.setTargetPoint(point: self.coordinates[key]!)
            self.startUpAndDown()
        }
        
        reachout = {[weak self] in
            self?.startReachOut()
        }
        
        put = {[weak self] in
            self?.startPut()
        }
        
        take = {[weak self] in
            self?.startTake()
        }
        
        hide = {[weak self] in
            self?.startHideHand()
        }
    }
    
    
    private func setHand(clenched: Bool = false) {
        robotTake = clenched ? getClenched() : getOpened()
    }
    
    
    private func getClenched() -> CGFloat {
        return 24
    }
    
    
    private func getOpened() -> CGFloat {
        return 30
    }
    
    
    private func setTargetPoint(point: CGPoint) {
        let screenSize = UIScreen.main.bounds
        let screenHeight = screenSize.height
        let ratioY = screenHeight / maxCanvasHeight // 1.34333
        localTargetY = point.y / ratioY
        let screenWidth = screenSize.width
        let ratioX = screenWidth / maxCanvasWidth // 1.34333
        localTargetX = point.x / ratioX - fingersLen
    }
    
    
    public func putOnly(coordinates: [Int: CGPoint], robotDelegates: [Int: RobotCompatibleProtocolDelegate]) {
        self.coordinates = coordinates
        self.robotDelegates = robotDelegates
        scoreCount = coordinates.count
        //let key = Array(coordinates)[0].key
        sorted = coordinates.keys.sorted(by: {$0 < $1})
        let key = sorted[0]
        
        setHand(clenched: true)
        sequence.append(upAndDown)
        sequence.append(reachout)
        sequence.append(put)
        sequence.append(hide)
        
        
        setTargetPoint(point: self.coordinates[key]!)
        currOperationNum = -1
        startNextOperation()
    }
    
    
    public func takeAndPut(coordinates: [Int: CGPoint], robotDelegates: [Int: RobotCompatibleProtocolDelegate]) {
        self.coordinates = coordinates
        self.robotDelegates = robotDelegates
        scoreCount = coordinates.count
        //let key = Array(coordinates)[0].key
        sorted = coordinates.keys.sorted(by: {$0 < $1})
        let key = sorted[0]
        
        setHand(clenched: false)
        sequence.append(upAndDown)
        sequence.append(reachout)
        sequence.append(take)
        sequence.append(hide)
        sequence.append(upAndDown)
        sequence.append(reachout)
        sequence.append(put)
        sequence.append(hide)
        
        setTargetPoint(point: self.coordinates[key]!)
        currOperationNum = -1
        startNextOperation()
    }
    
    
    private func startNextOperation(){
        if sequence.count - 1 > currOperationNum {
            currOperationNum += 1
            let operation = sequence[currOperationNum]
            operation?()
        }
    }
}




//MARK: - hand up/down

extension ScoreRobotView {
    
    private func startUpAndDown() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawUpAndDown), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawUpAndDown(){
        
        if robotHeight < localTargetY {
            robotHeight += robotHeightStep
        }
        
        if robotHeight > localTargetY {
            robotHeight -= robotHeightStep
        }
        
        self.setNeedsDisplay()
        
        if localTargetY-robotHeightStep...localTargetY+robotHeightStep ~= robotHeight {
            timer?.invalidate()
            startNextOperation()
        }
    }
}



//MARK: - hand right/left

extension ScoreRobotView {
    
    private func startReachOut() {
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
            startNextOperation()
        }
    }
    
    
    private func startHideHand() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawHideHand), userInfo: nil, repeats: true)
    }
    
    
    
    @objc private func redrawHideHand(){
        
        if robotArmLen >= 20 {
            robotArmLen -= robotArmStep
        }
        
        self.setNeedsDisplay()
        
        if robotArmLen < 20 {
            timer?.invalidate()
            startNextOperation()
        }
    }
}



//MARK: - hand take/put

extension ScoreRobotView {
    
    private func startTake() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawTake), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawTake(){
        
        if robotTake > getClenched() {
            robotTake -= robotTakeStep
        }
        
        self.setNeedsDisplay()
        
        if robotTake <= getClenched() {
            isTook = true
            
            let key = sorted[currIdx]
            currIdx += 1
            robotDelegates[key]?.didTake()
            timer?.invalidate()
            
            startNextOperation()
        }
    }
    
    
    private func startPut() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPut), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawPut(){
        
        if robotTake < getOpened() {
            robotTake += robotTakeStep
        }
        
        self.setNeedsDisplay()
        
        if robotTake >= getOpened() {
            isTook = false
            
            let key = sorted[currIdx]
            robotDelegates[key]?.didPut()
            timer?.invalidate()
            startNextOperation()
        }
    }
}
