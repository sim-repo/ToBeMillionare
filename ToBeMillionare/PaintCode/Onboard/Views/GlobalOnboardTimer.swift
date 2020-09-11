//
//  GlobalOnboardTimer.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 03.09.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit


class GlobalOnboardTimer {
    
    // timer vars:
    private var timer: Timer?
    var sequence: [(()->Void)?] = []
    var currOperationNum = -1
    
    enum Direction {
        case plus, minus
    }
    
    // phases:
    
    var completionsByPhase: [Int : [((CGFloat)->Void)]] = [:]
    
    // phase1:
    var phase1moveToOnboarding: (()->Void)? // 0 - 1
    var phase1_1moveToOnboarding: (()->Void)? // 0 - 1
    
    // phase2:
    var phase2showSpaceship: (()->Void)? // 0 - 0.1
    // phase3:
    var phase3movingSpaceship: (()->Void)? // 0.1 - 0.2
    // phase4:
    var phase4hitSpaceship: (()->Void)? // 0.2 - 0.8
    // phase5:
    var phase5brokenSpaceship: (()->Void)? // 0.8 - 1.0
    // phase6:
    var phase6alarmSpaceship: (()->Void)? // 1 - 2
    // phase7:
    var phase7zoomOutSpaceship: (()->Void)? // 1.21 - 2
    // phase8:
    var phase8showMercury: (()->Void)? // 2.1 - 3
    // phase9:
    var phase9showMercury: (()->Void)? // 3.1 - 4
    

    // redraw vars:
    var wingsMove: CGFloat = 1
    var disc1PathOpacity: CGFloat = 0
    var disc1Move: CGFloat = 1
    var disc2PathOpacity: CGFloat = 0
    var disc2Move: CGFloat = 1
    var disc3PathOpacity: CGFloat = 0
    var disc3Move: CGFloat = 1
    var disc4PathOpacity: CGFloat = 0
    var disc4Move: CGFloat = 1
    var discPassLight1: CGFloat = 0
    var discPassLight2: CGFloat = 0
    var discPassLight3: CGFloat = 0
    var discPassLight4: CGFloat = 0
    
    var arc1Move: CGFloat = 1
    var arc2Move: CGFloat = 1
    var arc3Move: CGFloat = 1
    var arc4Move: CGFloat = 1
    
    var redCubeMove: CGFloat = 1
    var redCubePathOpacity: CGFloat = 0
    var redCube2Move: CGFloat = 1
    var redCubePath2Opacity: CGFloat = 0
    var redCube3PathOpacity: CGFloat = 0
    var redCube3Move: CGFloat = 1
    
    var onboardingIndicatorsOpacity: CGFloat = 0
    var towerLightOpacity: CGFloat = 0
    
    var antennaMove1: CGFloat = 1
    var antennaMove2: CGFloat = 1
    
    var rayOpacity: CGFloat = 0
    var circlesMove: CGFloat = 1
    var circlesLightMove: CGFloat = 1
    var spaceDustMove: CGFloat = 1
    
    var moveToOnboard: CGFloat = 0
    var onboardAnimation: CGFloat = 0.0
}


//MARK:- Check Phase Functions
extension GlobalOnboardTimer {
    
    private func runCompletion(_ completions: [((CGFloat)->Void)], _ current: CGFloat) {
        for completion in completions {
            completion(current)
        }
    }
    
    private func checkPhase(current: inout CGFloat, target: CGFloat, step: CGFloat, completions: [((CGFloat)->Void)] ) {
        if current < target {
            current += step
        }
        runCompletion(completions, current)
        
        if target...target+step ~= current {
            current = target
            runCompletion(completions, current)
            timer?.invalidate()
            gotoSequence()
        }
    }
    
    
    private func checkPhase2(direction: Direction = .plus, current: inout CGFloat, target: CGFloat, step: CGFloat, completions: [((CGFloat)->Void)], _ phaseTarget: Bool? = nil) {
        
        if direction == .plus {
            if current < target {
                current += step
            }
        } else {
            if current > target {
                current -= step
            }
        }
        
        runCompletion(completions, current)
        
        if direction == .plus {
            if target...target+step ~= current {
                phaseFinish(&current, target, completions, phaseTarget)
            }
        } else {
            if target-step...0 ~= current {
                phaseFinish(&current, target, completions, phaseTarget)
            }
        }
    }
    
    private func phaseFinish(_ current: inout CGFloat, _ target: CGFloat, _ completions: [((CGFloat)->Void)], _ phaseTarget: Bool? = nil) {
        current = target
        runCompletion(completions, current)
        guard let _ = phaseTarget else { return }
        timer?.invalidate()
        gotoSequence()
    }
    
    
    private func gotoSequence(){
        if sequence.count - 1 > currOperationNum {
            currOperationNum += 1
            let operation = sequence[currOperationNum]
            operation?()
        }
    }
}



//MARK:- Check Phase Functions
extension GlobalOnboardTimer {
    
    public func startAnimation(phase1Completions: [((CGFloat)->Void)],
                               phase2Completions: [((CGFloat)->Void)],
                               phase3Completions: [((CGFloat)->Void)],
                               phase4Completions: [((CGFloat)->Void)],
                               phase5Completions: [((CGFloat)->Void)],
                               phase6Completions: [((CGFloat)->Void)],
                               phase7Completions: [((CGFloat)->Void)],
                               phase8Completions: [((CGFloat)->Void)],
                               phase9Completions: [((CGFloat)->Void)]) {
        
        completionsByPhase[0] = phase1Completions
        completionsByPhase[1] = phase2Completions
        completionsByPhase[2] = phase3Completions
        completionsByPhase[3] = phase4Completions
        completionsByPhase[4] = phase5Completions
        completionsByPhase[5] = phase6Completions
        completionsByPhase[6] = phase7Completions
        completionsByPhase[7] = phase8Completions
        completionsByPhase[8] = phase9Completions
        
        
        phase1moveToOnboarding = { [weak self] in self?.startPhase1() } // 0 - 1
        
        phase1_1moveToOnboarding = { [weak self] in self?.startPhase1_2() } // 0 - 1
        
        phase2showSpaceship = { [weak self] in self?.startPhase2() } // 0 - 0.1
        
        phase3movingSpaceship = { [weak self] in self?.startPhase3() } // 0.1 - 0.2
        
        phase4hitSpaceship = { [weak self] in self?.startPhase4() } // 0.2 - 0.8
        
        phase5brokenSpaceship = { [weak self] in self?.startPhase5() } // 0.8 - 1.0
        
        phase6alarmSpaceship = { [weak self] in self?.startPhase6() } // 1 - 1.21
        
        phase7zoomOutSpaceship = { [weak self] in self?.startPhase7() } // 1.21 - 2
        
        phase8showMercury = { [weak self] in self?.startPhase8() } // 2.1 - 3
        
        phase9showMercury = { [weak self] in self?.startPhase9() } // 3.1 - 4
        
        sequence.append(phase1moveToOnboarding)
        sequence.append(phase1_1moveToOnboarding)
        sequence.append(phase2showSpaceship)
        sequence.append(phase3movingSpaceship)
        sequence.append(phase4hitSpaceship)
        
        sequence.append(phase5brokenSpaceship)
        sequence.append(phase6alarmSpaceship)
        sequence.append(phase7zoomOutSpaceship)
        sequence.append(phase8showMercury)
        sequence.append(phase9showMercury)
        gotoSequence()
    }
    
    
    private func startPhase1() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase1), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase1(){
        guard let completions = completionsByPhase[0] else { return }
        checkPhase(current: &moveToOnboard, target: 0.086, step: 0.001, completions: completions)
    }
    
    private func startPhase1_2() {
        sleep(1)
        timer = Timer.scheduledTimer(timeInterval: 0.08, target: self, selector: #selector(self.redrawPhase1_2), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase1_2(){
        guard let completions = completionsByPhase[0] else { return }
        checkPhase(current: &moveToOnboard, target: 1, step: 0.08, completions: completions)
    }
    
    
    private func startPhase2() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase2), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase2(){
        
        guard let completions = completionsByPhase[1] else { return }
        
        var step: CGFloat = 0.02
        if onboardAnimation > 0.06 {
            step = 0.01
        }
        if onboardAnimation > 0.08 {
            step = 0.001
        }
        if onboardAnimation > 0.09 {
            step = 0.0005
        }
        checkPhase(current: &onboardAnimation, target: 0.1, step: step, completions: completions)
    }
    
    
    // moving:
    private func startPhase3() {
        //0.3
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase3), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase3(){
        guard let completions = completionsByPhase[2] else { return }
        //0.0005
        checkPhase(current: &onboardAnimation, target: 0.2, step: 0.01, completions: completions)
    }
    
    
    // meteorit:
    private func startPhase4() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase4), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase4(){
        guard let completions = completionsByPhase[3] else { return }
        checkPhase(current: &onboardAnimation, target: 0.8, step: 0.01, completions: completions)
    }
    
    
    // hit:
    private func startPhase5() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase5), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase5(){
        guard let completions = completionsByPhase[4] else { return }
        
        let step: CGFloat = 0.05
        checkPhase2(direction: .minus, current: &disc1Move, target: 0, step: step, completions: [completions[0]])
        checkPhase2(direction: .minus, current: &disc2Move, target: 0, step: step, completions: [completions[1]])
        checkPhase2(direction: .minus, current: &disc3Move, target: 0, step: step, completions: [completions[2]])
        checkPhase2(direction: .minus, current: &disc4Move, target: 0, step: step, completions: [completions[3]])
        checkPhase2(direction: .minus, current: &onboardingIndicatorsOpacity, target: 0, step: step, completions: [completions[4]])
        checkPhase2(direction: .minus, current: &towerLightOpacity, target: 0, step: step, completions: [completions[5]])
        checkPhase2(direction: .minus, current: &redCubeMove, target: 0, step: step, completions: [completions[6]])
        checkPhase2(direction: .minus, current: &redCube2Move, target: 0, step: step, completions: [completions[7]])
        checkPhase2(direction: .minus, current: &redCube3Move, target: 0, step: step, completions: [completions[8]])
        checkPhase2(direction: .minus, current: &arc1Move, target: 0, step: step, completions: [completions[9]])
        checkPhase2(direction: .minus, current: &arc2Move, target: 0, step: step, completions: [completions[10]])
        checkPhase2(direction: .minus, current: &arc3Move, target: 0, step: step, completions: [completions[11]])
        checkPhase2(direction: .plus,current: &onboardAnimation, target: 1, step: 0.003, completions: [completions[12], completions[13], completions[14]], true)
        checkPhase2(direction: .minus, current: &arc4Move, target: 0, step: step, completions: [completions[15]])
       // completions[15](0),
    }
    
    private func startPhase6() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase6), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase6(){
        guard let completions = completionsByPhase[5] else { return }
        checkPhase(current: &onboardAnimation, target: 1.2, step: 0.01, completions: completions)
    }
    
    private func startPhase7() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase7), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase7(){
        guard let completions = completionsByPhase[6] else { return }
        checkPhase(current: &onboardAnimation, target: 2, step: 0.01, completions: completions)
    }
    
    private func startPhase8() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase8), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase8(){
        guard let completions = completionsByPhase[7] else { return }
        checkPhase(current: &onboardAnimation, target: 3, step: 0.01, completions: completions)
    }
    
    private func startPhase9() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase9), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase9(){
        guard let completions = completionsByPhase[8] else { return }
        checkPhase(current: &onboardAnimation, target: 4, step: 0.01, completions: completions)
    }
}
