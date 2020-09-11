//
//  PlayButtonView.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 22.07.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit


class PlayBetView: UIView {
    
    enum Direction {
        case plus, minus
    }
    
    // timer vars:
    private var timer: Timer?
    
    // redraw vars:
    private var aim: CGFloat = 150 // in natural
    private var fireproofRound: CGFloat = 0 // in natural
    private var depo: CGFloat = 100 // in natural
    private var betSum: CGFloat = 10 // in fraction
    private var minAward: CGFloat = 20 // in natural
    private var zondRecovery: CGFloat = 25
    private var betTip: CGFloat = 0
    private var currencySymbol: String = ""
    
    private var targetDepo: CGFloat = 100
    private var targetFireproofRound: CGFloat = 25
    private var targetRecovery: CGFloat = 100
    private var targetAward: CGFloat = 0
    
    // phases
    private var phase1: (()->Void)? // betDepo
    private var phase2: (()->Void)? // betRemaining
    private var phase3: (()->Void)? // betRecovery
    
    
    private var sequence: [(()->Void)?] = []
    private var currOperationNum = -1
    
    
    private func gotoSequence(){
        if sequence.count - 1 > currOperationNum {
            currOperationNum += 1
            let operation = sequence[currOperationNum]
            operation?()
        }
    }
    
    
    private func checkPhase(direction: Direction = .plus, current: inout CGFloat, target: CGFloat, step: CGFloat) {
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
                setNeedsDisplay()
                timer?.invalidate()
                gotoSequence()
            }
        } else {
            if target-step...target ~= current {
                current = target
                setNeedsDisplay()
                timer?.invalidate()
                gotoSequence()
            }
        }
    }
    
    private func checkPhase(direction: Direction = .plus, current: inout CGFloat, target: CGFloat, step: CGFloat, completion: (()->Void)? = nil) {
        
        print("PlayBetView")
        
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
                completion?()
                gotoSequence()
            }
        } else {
            if target-step...target ~= current {
                current = target
                timer?.invalidate()
                completion?()
                gotoSequence()
            }
        }
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    
    override func draw(_ rect: CGRect) {
        if ScreenResolutionsEnum.screen() == .screen_47 {
            PlayScreenV2.drawBetScreen_47(frame: bounds, resizing: .aspectFit, betAim: aim, betFireproofLevel: "\(Int(fireproofRound))", betDepo: depo, betSum: betSum, betMinAward: minAward, betRecovery: zondRecovery, betTip: betTip, actualCurrencySymbol: currencySymbol)
        } else if ScreenResolutionsEnum.screen() == .screen_55 {
            PlayScreenV2.drawBetScreen_55(frame: bounds, resizing: .aspectFit, betAim: aim, betFireproofLevel: "\(Int(fireproofRound))", betDepo: depo, betSum: betSum, betMinAward: minAward, betRecovery: zondRecovery, betTip: betTip, actualCurrencySymbol: currencySymbol)
        } else if ScreenResolutionsEnum.screen() == .screen_58 {
            PlayScreenV2.drawBetScreen_58(frame: bounds, resizing: .aspectFit, betAim: aim, betFireproofLevel: "\(Int(fireproofRound))", betDepo: depo, betSum: betSum, betMinAward: minAward, betRecovery: zondRecovery, betTip: betTip, actualCurrencySymbol: currencySymbol)
        } else if ScreenResolutionsEnum.screen() == .screen_65 {
            PlayScreenV2.drawBetScreen_65(frame: bounds, resizing: .aspectFit, betAim: aim, betFireproofLevel: "\(Int(fireproofRound))", betDepo: depo, betSum: betSum, betMinAward: minAward, betRecovery: zondRecovery, betTip: betTip, actualCurrencySymbol: currencySymbol)
        }
    }
    
    
    public func setup(actualMoneyEnum: CurrencyEnum, betAim: Double, betDepo: CGFloat, betRecovery: Int, betSum: Double) {
        self.aim = CGFloat(betAim)
        currencySymbol = CurrencyEnum.getCurrencySymbol(currencyEnum: actualMoneyEnum)
        targetDepo = CGFloat(betDepo)
        targetRecovery = CGFloat(betRecovery)
        targetFireproofRound = 0
        fireproofRound = 0
        depo = 0
        self.zondRecovery = 0
        self.betSum = CGFloat(betSum)
        minAward = 0
        setNeedsDisplay()
    }
    

    
    public func start() {
        currOperationNum = -1
        sequence.removeAll()
        phase1 = { [weak self] in self?.startPhase1() }
        phase2 = { [weak self] in self?.startPhase2() }
        phase3 = { [weak self] in self?.startPhase3() }
        sequence.append(phase1)
        sequence.append(phase2)
        sequence.append(phase3)
        gotoSequence()
    }
    
    public func tip() {
        betTip = 0
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawTip), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawTip(){
        checkPhase(current: &betTip, target: 1, step: 0.01)
    }
    
    private func startPhase1() {
        timer = Timer.scheduledTimer(timeInterval: 0.0001, target: self, selector: #selector(self.redrawPhase1), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawPhase1(){
        
        checkPhase(current: &depo, target: targetDepo, step: targetDepo > 100 ? 25 : 5)
    }
    
    
    private func startPhase2() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase2), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawPhase2(){
        checkPhase(current: &fireproofRound, target: targetFireproofRound, step: 5)
    }
    
    private func startPhase3() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(self.redrawPhase3), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawPhase3(){
        checkPhase(current: &zondRecovery, target: targetRecovery, step: 5)
    }
    
    

    // update:
    public func update(betSum: Double, minAward: Double, fireproofRound: Int) {
        guard Double(self.betSum) != betSum else { return }
        currOperationNum = -1
        self.betSum = CGFloat(betSum)
        self.targetAward = CGFloat(minAward)
        self.targetFireproofRound = CGFloat(fireproofRound)
        startUpdate()
    }
    
    
    private func startUpdate() {
        sequence.removeAll()
        phase1 = { [weak self] in self?.startAward() }
        phase2 = { [weak self] in self?.startFireproof() }
        sequence.append(phase1)
        sequence.append(phase2)
        gotoSequence()
    }
    
    private func startAward() {
        timer?.invalidate()
        guard minAward != targetAward else { return }
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(self.redrawAward), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawAward(){
        
        let diff = abs( targetAward - minAward)
        
        if minAward > targetAward {
            checkPhase(direction: .minus, current: &minAward, target: targetAward, step: diff > 100 ? 25: 5)
        }
        if minAward < targetAward {
            checkPhase(direction: .plus, current: &minAward, target: targetAward, step: diff > 100 ? 25: 5)
        }
    }
    
    private func startFireproof() {
        timer?.invalidate()
        guard fireproofRound != targetFireproofRound else { return }
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(self.redrawFireproof), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawFireproof(){
        if fireproofRound > targetFireproofRound {
            checkPhase(direction: .minus, current: &fireproofRound, target: targetFireproofRound, step: 1)
        }
        if fireproofRound < targetFireproofRound {
            checkPhase(direction: .plus, current: &fireproofRound, target: targetFireproofRound, step: 1)
        }
    }
}


