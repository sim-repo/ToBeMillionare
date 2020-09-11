//
//  PlayButtonView.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 22.07.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit


class PlayStatView: UIView {
    
    enum Direction {
        case plus, minus
    }
    
    
    // timer vars:
    private var timer: Timer?
    
    // redraw vars:
    private var stageScoreAim: CGFloat = 0 // in natural
    private var beforeDisasterLeft: CGFloat = 0 // in natural
    private var depo: CGFloat = 0 // in natural
    private var award: CGFloat = 0 // in natural
    private var recovery: CGFloat = 0
    private var statRound: Int = 0
    private var statGamesCount: Int = 0
    private var actualCurrencyEnum: CurrencyEnum = .dollar
    private var moneyMove: CGFloat = 0
    private var isWin: Bool = false
    private var currencySymbol: String = ""
    
    private var targetAward: CGFloat = 0
    private var targetBeforeDisasterLeft: CGFloat = 0
    private var targetRecovery: CGFloat = 0
    
    
    // phases
    private var phase1: (()->Void)? // award
    private var phase2: (()->Void)? // money
    private var phase3: (()->Void)? // remains
    private var phase4: (()->Void)? // recovery
    
    private var sequence: [(()->Void)?] = []
    private var currOperationNum = -1
    
    private var step1: CGFloat = 0
    
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
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    
    override func draw(_ rect: CGRect) {
        if ScreenResolutionsEnum.screen() == .screen_47 {
            PlayScreenV2.drawStatScreen_47(frame: bounds, resizing: .aspectFit, betAim: stageScoreAim, betDepo: depo, betMinAward: award, betRecovery: recovery, statBeforeDisasterLeft: "\(Int(beforeDisasterLeft))", statLevel: "\(statRound)", statGamesCount: "\(statGamesCount)", actualCurrencyText: actualCurrencyEnum.rawValue, moneyMove: moneyMove, actualCurrencySymbol: currencySymbol)
        } else if ScreenResolutionsEnum.screen() == .screen_55 {
            PlayScreenV2.drawStatScreen_55(frame: bounds, resizing: .aspectFit, betAim: stageScoreAim, betDepo: depo, betMinAward: award, betRecovery: recovery, statBeforeDisasterLeft: "\(Int(beforeDisasterLeft))", statLevel: "\(statRound)", statGamesCount: "\(statGamesCount)", actualCurrencyText: actualCurrencyEnum.rawValue, moneyMove: moneyMove, actualCurrencySymbol: currencySymbol)
        } else if ScreenResolutionsEnum.screen() == .screen_58 {
            PlayScreenV2.drawStatScreen_58(frame: bounds, resizing: .aspectFit, betAim: stageScoreAim, betDepo: depo, betMinAward: award, betRecovery: recovery, statBeforeDisasterLeft: "\(Int(beforeDisasterLeft))", statLevel: "\(statRound)", statGamesCount: "\(statGamesCount)", actualCurrencyText: actualCurrencyEnum.rawValue, moneyMove: moneyMove, actualCurrencySymbol: currencySymbol)
        } else if ScreenResolutionsEnum.screen() == .screen_65 {
            PlayScreenV2.drawStatScreen_65(frame: bounds, resizing: .aspectFit, betAim: stageScoreAim, betDepo: depo, betMinAward: award, betRecovery: recovery, statBeforeDisasterLeft: "\(Int(beforeDisasterLeft))", statLevel: "\(statRound)", statGamesCount: "\(statGamesCount)", actualCurrencyText: actualCurrencyEnum.rawValue, moneyMove: moneyMove, actualCurrencySymbol: currencySymbol)
        }
    }
    
    
    public func setup(actualMoneyEnum: CurrencyEnum, stageScoreAim: Double, beforeDisasterLeft: Int, depo: Double, zondRecovery: Int, award: Double, round: Int, gamesCount: Int) {
        
        isWin = award > 0
        moneyMove = isWin ? 0 : 1
        self.actualCurrencyEnum = actualMoneyEnum
        currencySymbol = CurrencyEnum.getCurrencySymbol(currencyEnum: actualCurrencyEnum)
        self.stageScoreAim = CGFloat(stageScoreAim)
        targetBeforeDisasterLeft = CGFloat(beforeDisasterLeft)
        targetAward = CGFloat(award)
        targetRecovery = CGFloat(zondRecovery)
        self.statRound = round
        self.statGamesCount = gamesCount
        self.depo = CGFloat(depo)
        self.recovery = 0
        self.award = 0
        setupTiming(depo: self.depo, award: self.award)
        setNeedsDisplay()
    }
    
    
    //MARK:- Timing:
    private func setupTiming(depo: CGFloat, award: CGFloat){
        if abs(depo - abs(award)) < 30 {
            step1 = 1
        } else if abs(depo - abs(award)) < 100 {
            step1 = 5
        } else {
            step1 = 10
        }
    }
    
    
    public func start() {
        phase1 = { [weak self] in self?.startPhase1() }
        phase2 = { [weak self] in self?.startPhase2() }
        phase3 = { [weak self] in self?.startPhase3() }
        phase4 = { [weak self] in self?.startPhase4() }
        sequence.append(phase1)
        sequence.append(phase2)
        sequence.append(phase3)
        sequence.append(phase4)
        gotoSequence()
    }
    
    private func startPhase1() {
        timer = Timer.scheduledTimer(timeInterval: 0.0001, target: self, selector: #selector(self.redrawPhase1), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawPhase1(){
        checkPhase(direction: award < targetAward ? .plus: .minus, current: &award, target: targetAward, step: step1)
    }
    
    private func startPhase2() {
        timer = Timer.scheduledTimer(timeInterval: 0.04, target: self, selector: #selector(self.redrawPhase2), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawPhase2(){
        checkPhase(direction: isWin ? .plus: .minus, current: &moneyMove, target: isWin ? 1.0:0.0, step: 0.04)
    }
    
    
    private func startPhase3() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(self.redrawPhase3), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawPhase3(){
        checkPhase(current: &recovery, target: targetRecovery, step: 5)
    }
    
    private func startPhase4() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(self.redrawPhase4), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawPhase4(){
        checkPhase(current: &beforeDisasterLeft, target: targetBeforeDisasterLeft, step: 1)
    }
}


