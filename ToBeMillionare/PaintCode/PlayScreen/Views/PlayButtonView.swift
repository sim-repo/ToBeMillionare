//
//  PlayButtonView.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 22.07.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit


class PlayButtonView: UIView {
    
    
    // control vars:
    private var isReady: Bool = true
    
    
    // timer vars:
    private var timer: Timer?
    private var id: String = ""
    private var completion: (()->Void)? = nil
    
    // redraw vars:
    private var answerBlink: CGFloat = 0
    private var answerOpen: CGFloat = 0
    private var answerIsTrue: Bool = false
    private var answerText: String = ""
    private var answerTextOpacity: CGFloat = 0
    
    enum Direction {
        case plus, minus
    }


    private var phase1: (()->Void)?
    private var phase2: (()->Void)?
    private var phase3: (()->Void)?

    private var phaseStep1: CGFloat = 0
    private var phaseStep2: CGFloat = 0
    private var phaseStep3: CGFloat = 0
    
    
    
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
    
    
    private func checkFinish(_ completion: (()->Void)? = nil) {
        guard let completion = completion else { return }
        completion()
        isReady = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    
    override func draw(_ rect: CGRect) {
        PlayScreenV2.drawButtonView(frame: bounds,
                                    answerBlink: answerBlink,
                                    answerOpen: answerOpen,
                                    answerIsTrue: answerIsTrue,
                                    answerText: answerText,
                                    answerTextOpacity: answerTextOpacity)
    }
    
    public func setup(id: String) {
        self.id = id
    }
    
    public func startAnswerTextShow(answerText: String, delay: Double, completion: (()->Void)?) {
        
        guard isReady else { return }
        isReady = false
        
        self.answerText = answerText
        self.completion = completion
        answerTextOpacity = 0.0
        setNeedsDisplay()
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(self.redrawAnswerShow), userInfo: nil, repeats: true)
    }

    
    @objc private func redrawAnswerShow(){
        checkPhase(current: &answerTextOpacity, target: 1.0, step: 0.05, completion: completion)
    }
    
    public func startAnswerTextHide() {
        answerTextOpacity = 0.0
        setNeedsDisplay()
    }

    
    public func startOpenTrue(id: String, _ roundEnum: RoundEnum, _ completion: (()->Void)?) {
        guard isReady else { return }
        isReady = false
        
        reset()
        self.answerIsTrue = self.id == id
        self.completion = completion
        setupTiming(roundEnum: roundEnum)
        phase1 = { [weak self] in self?.startPhase1() }
        phase2 = { [weak self] in self?.startPhase2() }
        phase3 = { [weak self] in self?.startPhase3() }
        sequence.append(phase1)
        sequence.append(phase2)
        sequence.append(phase3)
        gotoSequence()
    }
    
    
    private func reset() {
        answerBlink = 0
        answerOpen = 0
    }
    
    //MARK:- Timing:
    private func setupTiming(roundEnum: RoundEnum){
        let round = roundEnum.rawValue
        if round < 5 {
            phaseStep1 = 0.04//blink
            phaseStep2 = 0.04//show answer
            phaseStep3 = 0.08//hide answer
        }
        if 5...7 ~= round {
            phaseStep1 = 0.03//blink
            phaseStep2 = 0.03//show answer
            phaseStep3 = 0.06//hide answer
        }
        
        if 8...10 ~= round {
            phaseStep1 = 0.01//blink
            phaseStep2 = 0.02//show answer
            phaseStep3 = 0.03//hide answer
        }
        
        if 11...12 ~= round {
            phaseStep1 = 0.007//blink
            phaseStep2 = 0.02//show answer
            phaseStep3 = 0.06//hide answer
        }
        
        if round == 13 {
            phaseStep1 = 0.004//blink
            phaseStep2 = 0.02//show answer
            phaseStep3 = 0.06//hide answer
        }
    }
    
    private func startPhase1() {
        timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(self.redrawPhase1), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawPhase1(){
        checkPhase(current: &answerBlink, target: 1.0, step: phaseStep1)
    }
    
    
    private func startPhase2() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(self.redrawPhase2), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawPhase2(){
        checkPhase(direction: .plus, current: &answerOpen, target: 1.0, step: phaseStep2)
    }
    
    private func startPhase3() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(self.redrawPhase3), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawPhase3(){
        checkPhase(direction: .minus, current: &answerOpen, target: 0.0, step: phaseStep3, completion: completion)
    }
}
