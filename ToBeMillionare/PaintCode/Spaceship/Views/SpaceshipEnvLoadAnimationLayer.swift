//
//  SpaceshipEnvironment.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 10.07.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//


import UIKit


class SpaceshipEnvLoadAnimationLayer: UIView {
    
    // timer vars:
    private var timer: Timer?
    
    // control vars:
    private var smoothOnceAnimation: CGFloat = 0.0
    private var score: CGFloat = 0.0
    private var targetScore: CGFloat = 0.0
     
    private var completion: (()->Void)? = nil
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        if ScreenResolutionsEnum.screen() == .screen_47 {
            SpaceshipEnvironmentScreen.drawSpaceshipLoadingAnimationLayer_47(frame: bounds,
                                                                      discreteAnimation1: smoothOnceAnimation,
                                                                      smoothOnceAnimation: smoothOnceAnimation,
                                                                      scoreFraction: score)
        } else {
            SpaceshipEnvironmentScreen.drawSpaceshipLoadingAnimationLayer(frame: bounds,
            discreteAnimation1: smoothOnceAnimation,
            smoothOnceAnimation: smoothOnceAnimation,
            scoreFraction: score)
        }
    }
    
    public func stop() {
        timer?.invalidate()
        timer = nil
    }
    
    private func reset() {
        completion = nil
    }
    
    private func runOnce(timer: Timer, current: inout CGFloat, target: CGFloat, step: CGFloat) {
        
        if current < target {
            current += step
        }
        
        self.setNeedsDisplay()
        
        if target...target+step ~= current {
            timer.invalidate()
            completion?()
        }
    }
    
    
    public func startAnimation(completion: (()->Void)? = nil) {
        self.completion = completion
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawTimer(){
        guard let timer = timer else { return }
        runOnce(timer: timer, current: &smoothOnceAnimation, target: 1.0, step: 0.04)
    }
    
    
    public func startScoreAnimation(stage: Int, score: Double) {
        reset()
        targetScore = CGFloat(Double(stage * 1000) + score)*0.0001 - 0.1 // 1000 = 0.1, 2000 = 0.2 2000*x = 0.1
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawScore), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawScore(){
        guard let timer = timer else { return }
        runOnce(timer: timer, current: &score, target: targetScore, step: 0.01)
    }
}




