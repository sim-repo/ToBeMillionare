//
//  PlayButtonView.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 22.07.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit


class PlayScoreView: UIView {
    
    enum Direction {
        case plus, minus
    }
    
    // control vars:
    private var isReady: Bool = true
    
    // timer vars:
    private var timer: Timer?
    private var completion: (()->Void)? = nil
    
    // redraw vars:
    private var scoreAim: CGFloat = 300 // in natural
    private var scoreAward: CGFloat = 10 // in natural
    private var scoreAwardOpacity: CGFloat = 0 // in fraction
    private var scoreDepo: CGFloat = 200 // in natural
    private var scoreAddedDepo: CGFloat = 0
    private var scoreFireproofTip: CGFloat = 0
    private var scoreFireproofRem: Int = 0
    private var scoreFireproofTipAchieve: CGFloat = 0
    
    // phases
    private var phase1: (()->Void)? // scoreAward = <10>, scoreAwardOpacity == 1
    private var phase2: (()->Void)? // incremental(scoreDepo + scoreAward)
    private var phase3: (()->Void)? // awardOpacity == 0
    private var phase4: (()->Void)? // fireproofOpacity == 1
    private var phase5: (()->Void)? // fireproofOpacity == 0
    
    
    private var phaseStep1: CGFloat = 0
    private var phaseStep2: CGFloat = 0
    private var phaseStep3: CGFloat = 0
    private var phaseStep4: CGFloat = 0
    private var phaseStep5: CGFloat = 0
    private var sleepPhaseStep5: Double = 0.5
    
    private var sequence: [(()->Void)?] = []
    private var currOperationNum = -1
    
    
    private func gotoSequence(){
        if sequence.count - 1 > currOperationNum {
            currOperationNum += 1
            let operation = sequence[currOperationNum]
            operation?()
        }
    }
    
    
    private func checkPhase(direction: Direction = .plus, current: inout CGFloat, target: CGFloat, step: CGFloat, completion: (()->Void)? = nil) {
        if direction == .plus {
            if current < target {
                current += step
            }
        } else {
            if current > target {
                current -= step
            }
        }
        
        self.setNeedsDisplay()
        if direction == .plus {
            if target...target+step ~= current {
                current = target
                timer?.invalidate()
                checkFinish(completion)
                gotoSequence()
            }
        } else {
            if target-step...target ~= current {
                current = target
                timer?.invalidate()
                checkFinish(completion)
                gotoSequence()
            }
        }
    }
    
    
    private func checkFinish(_ completion: (()->Void)? = nil ) {
        guard isReady == false else { return }
        guard let completion = completion else { return }
        completion()
        isReady = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    
    override func draw(_ rect: CGRect) {
        PlayScreenV2.drawScoreView(frame: bounds,
                                   resizing: .aspectFit,
                                   scoreAim: scoreAim,
                                   scoreAward: scoreAward,
                                   scoreAwardOpacity: scoreAwardOpacity,
                                   scoreDepo: scoreDepo,
                                   scoreFireproofTip: scoreFireproofTip,
                                   scoreFireproofRem: "\(scoreFireproofRem)",
                                   scoreFireproofTipAchieve: scoreFireproofTipAchieve)
        
    }
    
    public func setup(scoreAim: Double, scoreDepo: Double) {
        self.scoreAim = CGFloat(scoreAim)
        self.scoreDepo = CGFloat(scoreDepo)
    }
    
    
    
    public func startAward(nextRoundEnum: RoundEnum, scoreAward: Int, scoreFireproofRem: Int, completion: (()->Void)? = nil) {
        
        guard isReady else { return }
        isReady = false
        
        setupTiming(nextRoundEnum)
        
        sequence.removeAll()
        currOperationNum = -1
        self.scoreAward = CGFloat(scoreAward)
        self.scoreFireproofRem = scoreFireproofRem
        self.completion = completion
        scoreAddedDepo = scoreDepo + CGFloat(scoreAward)
        
        phase1 = { [weak self] in self?.startPhase1() }
        phase2 = { [weak self] in self?.startPhase2() }
        phase3 = { [weak self] in self?.startPhase3() }
        phase4 = { [weak self] in self?.startPhase4() }
        phase5 = { [weak self] in self?.startPhase5() }
        sequence.append(phase1)
        sequence.append(phase2)
        sequence.append(phase3)
        if scoreFireproofRem >= 0 {
            sequence.append(phase4)
            sequence.append(phase5)
        }
        gotoSequence()
    }
    
    //MARK:- Timing:
    private func setupTiming(_ roundEnum: RoundEnum){
        let round = roundEnum.rawValue
        if round < 5 {
            phaseStep1 = 0.08 // show award
            phaseStep2 = 2 // show depo
            phaseStep3 = 0.2 // hide award
            phaseStep4 = 0.2 // show tip
            phaseStep5 = 0.2 // hide tip
        }
        if 5...7 ~= round {
            phaseStep1 = 0.05
            phaseStep2 = 2
            phaseStep3 = 0.2
            phaseStep4 = 0.1
            phaseStep5 = 0.1
        }
    }

    
    private func startPhase1() {
        timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(self.redrawPhase1), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawPhase1(){
        checkPhase(current: &scoreAwardOpacity, target: 1.0, step: phaseStep1)
    }
    
    
    private func startPhase2() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(self.redrawPhase2), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawPhase2(){
        checkPhase(direction: .plus, current: &scoreDepo, target: scoreAddedDepo, step: phaseStep2)
    }
    
    
    private func startPhase3() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(self.redrawPhase3), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawPhase3(){
        if scoreFireproofRem < 0 {
            guard scoreAwardOpacity > 0 else { // additional check!
                           timer?.invalidate()
                           return }
            checkPhase(direction: .minus, current: &scoreAwardOpacity, target: 0.0, step: phaseStep3, completion: completion)
        } else {
            checkPhase(direction: .minus, current: &scoreAwardOpacity, target: 0.0, step: phaseStep3)
        }
    }
    
    
    private func startPhase4() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(self.redrawPhase4), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase4(){
        if scoreFireproofRem == 0 {
            checkPhase(direction: .plus, current: &scoreFireproofTipAchieve, target: 1.0, step: phaseStep4)
        } else {
            checkPhase(direction: .plus, current: &scoreFireproofTip, target: 1.0, step: phaseStep4)
        }
    }
    
    
    private func startPhase5() {
        mysleep(sleepPhaseStep5)
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(self.redrawPhase5), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawPhase5(){
       
        
        if scoreFireproofRem == 0 {
            guard scoreFireproofTipAchieve > 0 else { // additional check!
                timer?.invalidate()
                return }
            checkPhase(direction: .minus, current: &scoreFireproofTipAchieve, target: 0.0, step: phaseStep5, completion: completion)
        } else {
            guard scoreFireproofTip > 0 else {
            timer?.invalidate()
            return }
            checkPhase(direction: .minus, current: &scoreFireproofTip, target: 0.0, step: phaseStep5, completion: completion)
        }
    }
}

