//
//  LogoDustLayer.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 04.08.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

// #0004
class Ava: UIView {
    
    enum BlinkType{
        case ava,detail
    }
    
    // control vars
    private var isReadyForPress: Bool = true
    private var isReadyBlink: Bool = true
    
    // timer vars:
    private var timer: Timer?
    private var subtimer: Timer?
    
    // redraw vars:
    private var showAva: CGFloat = 0.0
    private var showDetails: CGFloat = 0.0
    private var showStageScore: CGFloat = 0.0
    private var showDetailBlink: CGFloat = 0.0
    private var showBankScore: CGFloat = 0.0
    private var showBlink: CGFloat = 0
    private var depoText: String = ""
    private var stageText: String = ""
    private var targetStageScore: CGFloat = 0.0
    private var targetBankScore: CGFloat = 0.0
    
    private var blinkType: BlinkType = .ava
    
    enum Direction {
        case plus, minus
    }
    
    
    private var completion: (()->Void)? = nil
    
    // phases:
    private var phase1: (()->Void)?
    private var phase2: (()->Void)?
    private var phase3: (()->Void)?
    private var phase4: (()->Void)?
    
    private var sequence: [(()->Void)?] = []
    private var currOperationNum = -1
    
    
    private var phaseStep1: CGFloat = 0
    private var phaseStep2: CGFloat = 0
    private var phaseStep3 : CGFloat = 0
    private var phaseStep4 : CGFloat = 0
    
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        AvaKit.drawAva(frame: bounds,
                       resizing: .aspectFit,
                       showAva: showAva,
                       showDetails: showDetails,
                       showStageScore: showStageScore,
                       showBankScore: showBankScore,
                       showDetailBlink: showDetailBlink,
                       showBlink: showBlink,
                       depoText: depoText,
                       stageText: stageText
                        )
    }
    
    public func stop() {
        isReadyBlink = true
        subtimer?.invalidate()
        timer?.invalidate()
    }
    
    public func reset() {
      isReadyForPress = true
      isReadyBlink = true
    }
    
    
    private func gotoSequence(){
        if sequence.count - 1 > currOperationNum {
            currOperationNum += 1
            let operation = sequence[currOperationNum]
            operation?()
        }
    }
    
   
    private func checkPhase(direction: Direction = .plus, current: inout CGFloat, target: CGFloat, step: CGFloat, completion: (()->Void)? = nil) {
        if direction == .plus {
            if current <= target {
                current += step
            }
        } else {
            if current > target {
                current -= step
            }
        }
        setNeedsDisplay()
        if direction == .plus {
            if target...target+step ~= current {
                current = target
                setNeedsDisplay()
                timer?.invalidate()
                checkFinish(completion)
                gotoSequence()
            }
        } else {
            if target-step...target ~= current {
                current = target
                setNeedsDisplay()
                timer?.invalidate()
                checkFinish(completion)
                gotoSequence()
            }
        }
    }
    
    private func checkFinish(_ completion: (()->Void)? = nil) {
        guard isReadyForPress == false else { return }
        guard let completion = completion else { return }
        completion()
        isReadyForPress = true
    }
}


// MARK:- Appearance
extension Ava {
    
    public func startAppearance(currencySymbol: String, currentStage: Int, depo: Double, completion: (()->Void)? ) {
        guard isReadyForPress else { return }
        isReadyForPress = false
        stop()
        showAva = 0.0
        showDetails = 0.0
        showStageScore = 0.0
        showDetailBlink = 0.0
        showBankScore = 0.0
        showBlink = 0.0
        targetStageScore = CGFloat(MyConverter.stageToFraction(stage: currentStage, depo: depo))
        targetBankScore = CGFloat(MyConverter.depoToFraction(depo: depo))
        depoText = currencySymbol+"\(Int(depo))"
        stageText = "\(currentStage)"
        self.completion = completion
        setupPhases1()
    }
    
    
    private func setupPhases1() {
        phase1 = { [weak self] in self?.startPhase1_1() }
        phase2 = { [weak self] in self?.startPhase1_2() }
        phase3 = { [weak self] in self?.startPhase1_3() }
        phase4 = { [weak self] in self?.startPhase1_4() }
        sequence.append(phase1)
        sequence.append(phase2)
        sequence.append(phase3)
        sequence.append(phase4)
        gotoSequence()
    }
    
    private func startPhase1_1() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval:0.01, target: self, selector: #selector(self.redrawPhase1_1), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase1_1(){
        checkPhase(direction: .plus, current: &showAva, target: 0.31, step: 0.01)
    }
    
    private func startPhase1_2() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval:0.01, target: self, selector: #selector(self.redrawPhase1_2), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase1_2(){
        checkPhase(direction: .plus, current: &showDetails, target: 0.31, step: 0.01)
    }
    
    private func startPhase1_3() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval:0.01, target: self, selector: #selector(self.redrawPhase1_3), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase1_3(){
        checkPhase(direction: .plus, current: &showStageScore, target: targetStageScore, step: 0.02)
    }
    
    private func startPhase1_4() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval:0.01, target: self, selector: #selector(self.redrawPhase1_4), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase1_4(){
        checkPhase(direction: .plus, current: &showBankScore, target: targetBankScore, step: 0.02, completion: completion)
    }
}


// MARK:- Press
extension Ava {
    
    public func didPress(completion: (()->Void)? ) {
        guard isReadyForPress else { return }
        isReadyForPress = false
        stop()
        self.completion = completion
        setupPhases2()
    }
    

    private func setupPhases2() {
        showAva = 1
        showDetails = 1
        
        phase1 = { [weak self] in self?.startPhase2_1() }
        phase2 = { [weak self] in self?.startPhase2_2() }
        sequence.append(phase1)
        sequence.append(phase2)
        gotoSequence()
    }
    
    private func startPhase2_1() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval:0.004, target: self, selector: #selector(self.redrawPhase2_1), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawPhase2_1(){
        checkPhase(direction: .minus, current: &showDetails, target: 0.5, step: 0.01)
    }
    
    private func startPhase2_2() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval:0.004, target: self, selector: #selector(self.redrawPhase2_2), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase2_2(){
        checkPhase(direction: .minus, current: &showAva, target: 0.5, step: 0.01, completion: completion)
    }
}



// MARK:- Blink
extension Ava {
    
    
    public func tryBlink(){
        guard isReadyBlink else { return }
        isReadyBlink = false
        setNeedsDisplay()
        startBlink()
    }
    
    private func restartBlink() {
        subtimer?.invalidate()
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.startBlink), userInfo: nil, repeats: true)
    }
    
    @objc private func startBlink() {
       showBlink = 0
       showDetailBlink = 0
       blinkType = blinkType == .ava ? .detail : .ava
       subtimer?.invalidate()
       subtimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(self.redrawBlink), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawBlink(){
        switch blinkType {
        case .ava:
            checkPeriodicity(current: &showBlink, step: 0.02)
        case .detail:
            checkPeriodicity(current: &showDetailBlink, step: 0.02)
        }
    }
    
    private func checkPeriodicity(current: inout CGFloat, step: CGFloat) {
        current += step
        setNeedsDisplay()
        if 1...1+step ~= current {
            current = 1
            setNeedsDisplay()
            restartBlink()
        }
    }
}

