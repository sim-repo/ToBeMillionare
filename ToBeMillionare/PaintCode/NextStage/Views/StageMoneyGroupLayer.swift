//
//  PlayButtonView.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 22.07.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit


class StageMoneyGroupLayer: UIView {
    
    enum Direction {
        case plus, minus
    }
    
    
    // timer vars:
    private var timer: Timer?
    private var subtimer: Timer?
    
    private var firstTime: Bool = true
    // control vars:
    private var highlightMoneyStoke: CGFloat = 0
    
    private var direction: Direction = .plus
    
    private func checkPhase(direction: Direction = .plus, current: inout CGFloat, step: CGFloat) {
        if direction == .plus {
            if current < 1.0 {
                current += step
            }
        } else {
            if current > 0.0 {
                current -= step
            }
        }
        self.setNeedsDisplay()
        if direction == .plus {
            if 1.0...1.0+step ~= current {
                current = 1.0
                setNeedsDisplay()
                subtimer?.invalidate()
                startTimer()
            }
        } else {
            if -step...0.0 ~= current {
                current = 0.0
                setNeedsDisplay()
                subtimer?.invalidate()
                startTimer()
            }
        }
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    
    override func draw(_ rect: CGRect) {
        if ScreenResolutionsEnum.screen() == .screen_47 {
            NextStageKit.drawMoneyGroupLayer_47(frame: bounds, resizing: .aspectFit, highlightMoneyStoke: highlightMoneyStoke)
        } else if ScreenResolutionsEnum.screen() == .screen_55 {
            NextStageKit.drawMoneyGroupLayer_55(frame: bounds, resizing: .aspectFit, highlightMoneyStoke: highlightMoneyStoke)
        } else if ScreenResolutionsEnum.screen() == .screen_58 {
            NextStageKit.drawMoneyGroupLayer_58(frame: bounds, resizing: .aspectFit, highlightMoneyStoke: highlightMoneyStoke)
        } else if ScreenResolutionsEnum.screen() == .screen_65 {
            NextStageKit.drawMoneyGroupLayer_65(frame: bounds, resizing: .aspectFit, highlightMoneyStoke: highlightMoneyStoke)
        }
    }
    
    
    
    public func stop() {
        timer?.invalidate()
        timer = nil
        subtimer?.invalidate()
        subtimer = nil
    }
    
    
    public func startHighlight() {
        startSubtimer()
    }
    
    private func startTimer() {
        guard firstTime else { return }
        firstTime = false
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(self.startSubtimer), userInfo: nil, repeats: true)
    }
    
    
    @objc private func startSubtimer(){
        highlightMoneyStoke = 0
        subtimer?.invalidate()
        subtimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(self.redrawHighlight), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawHighlight(){
        checkPhase(direction: direction, current: &highlightMoneyStoke, step: 0.01)
    }
}



