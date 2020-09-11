//
//  PlayNextRoundView.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 23.07.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

//TODO: bug here
class NextScreenView: UIView {
    

    
    // control vars:
    private var isReady: Bool = true
    
    // timer vars:
    private var timer: Timer?
    
    // redraw vars:
    private var moveCovers: CGFloat = 0
    private var opacity: CGFloat = 0
    private var nextScreenTitle: String = ""
    
    enum Direction {
        case plus, minus
    }
    
    
    private var completion: (()->Void)? = nil
    
    // phases:
    private var phase1: (()->Void)?
    private var phase2: (()->Void)?
    private var phase3: (()->Void)?
    
    private var sequence: [(()->Void)?] = []
    private var currOperationNum = -1
    
    
    private var phaseStep1: CGFloat = 0
    private var phaseStep2: CGFloat = 0
    private var phaseStep3 : CGFloat = 0.01
    private var sleepPhaseStep2: Double = 1
    
    
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
        if ScreenResolutionsEnum.screen() == .screen_47 {
            CommonKit.drawNextScreen_47(frame: bounds, nextScreenMove: moveCovers, nextScreenOpacity: opacity, nextScreenTitle: nextScreenTitle)
        } else if ScreenResolutionsEnum.screen() == .screen_55 {
            CommonKit.drawNextScreen_55(frame: bounds, nextScreenMove: moveCovers, nextScreenOpacity: opacity,
                                        nextScreenTitle: nextScreenTitle)
        } else if ScreenResolutionsEnum.screen() == .screen_58 {
            CommonKit.drawNextScreen_58(frame: bounds, nextScreenMove: moveCovers, nextScreenOpacity: opacity,nextScreenTitle: nextScreenTitle)
        } else if ScreenResolutionsEnum.screen() == .screen_65 {
            CommonKit.drawNextScreen_65(frame: bounds, nextScreenMove: moveCovers, nextScreenOpacity: opacity,nextScreenTitle: nextScreenTitle)
        }
    }
    
    //MARK:- Timing:
    private func setupTiming(_ nextRoundEnum: RoundEnum){
        let round = nextRoundEnum.rawValue
        if round < 7 {
            phaseStep1 = 0.4
            phaseStep2 = 0.1
            phaseStep3 = 0.05
            sleepPhaseStep2 = 1
        }
        if 7...10 ~= round {
            phaseStep1 = 0.05
            phaseStep2 = 0.05
            phaseStep3 = 0.02
        }
        
        if 11...12 ~= round {
            phaseStep1 = 0.04
            phaseStep2 = 0.04
            phaseStep3 = 0.008
        }
        
        if round == 13 {
            phaseStep1 = 0.03
            phaseStep2 = 0.02
            phaseStep3 = 0.006
            sleepPhaseStep2 = 3
        }
    }
    
    public func start(nextRoundEnum: RoundEnum, title: String, completion: (()->Void)? = nil) {
        guard isReady else { return }
        isReady = false
   
        setupTiming(nextRoundEnum)
        self.completion = completion
        self.nextScreenTitle = title
        phase1 = { [weak self] in self?.startPhase1() }
        phase2 = { [weak self] in self?.startPhase2() }
        phase3 = { [weak self] in self?.startPhase3() }
        sequence.append(phase1)
        sequence.append(phase2)
        sequence.append(phase3)
        gotoSequence()
    }
    
    
    private func startPhase1() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase1), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawPhase1(){
        checkPhase(current: &moveCovers, target: 1.0, step: phaseStep1)
    }
    
    
    private func startPhase2() {
        opacity = 0.001
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase2), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawPhase2(){
        if moveCovers == 1.0 {
            mysleep(sleepPhaseStep2)
        }
        checkPhase(direction: .minus, current: &moveCovers, target: 0.0, step: phaseStep2)
    }
    
    
    private func startPhase3() {
        timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(self.redrawPhase3), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawPhase3(){
        checkPhase(current: &opacity, target: 1.0, step: phaseStep3, completion: completion)
    }
}
