//
//  PlayButtonView.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 22.07.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit


class StageDataLayer: UIView {
    
    enum Direction {
        case plus, minus
    }
    
    
    // timer vars:
    private var timer: Timer?
    private var firstTime: Bool = true
    private var subtimer: Timer?
    
    // control vars:
    private var stageNum: Int = 0
    private var zondRecovery: Int = 0
    private var beforeDisasterLeft: Int = 0
    
    private var startAnimation: CGFloat = 0
    private var highlightTitle: CGFloat = 0
  
    private var direction: Direction = .minus
    
    
    private var completion: (()->Void)? = nil
    
    
    private func checkPhase(direction: Direction = .plus, current: inout CGFloat, step: CGFloat, completion: (()->Void)? = nil) {
        
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
                completion?()
            }
        } else {
            if -step...0.0 ~= current {
                current = 0.0
                setNeedsDisplay()
                subtimer?.invalidate()
                startTimer()
                completion?()
            }
        }
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    
    override func draw(_ rect: CGRect) {
        if ScreenResolutionsEnum.screen() == .screen_47 {
            NextStageKit.drawDataLayer_47(frame: bounds, resizing: .aspectFit, stageNum: CGFloat(stageNum), zondRecovery: CGFloat(zondRecovery), beforeDisasterLeft: "\(beforeDisasterLeft)", startAnimation: startAnimation, highlightTitle: highlightTitle)
        } else if ScreenResolutionsEnum.screen() == .screen_55 {
            NextStageKit.drawDataLayer_55(frame: bounds, resizing: .aspectFit, stageNum: CGFloat(stageNum), zondRecovery: CGFloat(zondRecovery), beforeDisasterLeft: "\(beforeDisasterLeft)", startAnimation: startAnimation, highlightTitle: highlightTitle)
        } else if ScreenResolutionsEnum.screen() == .screen_58 {
            NextStageKit.drawDataLayer_58(frame: bounds, resizing: .aspectFit, stageNum: CGFloat(stageNum), zondRecovery: CGFloat(zondRecovery), beforeDisasterLeft: "\(beforeDisasterLeft)", startAnimation: startAnimation, highlightTitle: highlightTitle)
        } else if ScreenResolutionsEnum.screen() == .screen_65 {
            NextStageKit.drawDataLayer_65(frame: bounds, resizing: .aspectFit, stageNum: CGFloat(stageNum), zondRecovery: CGFloat(zondRecovery), beforeDisasterLeft: "\(beforeDisasterLeft)", startAnimation: startAnimation, highlightTitle: highlightTitle)
        }
    }
    
    public func stop() {
        timer?.invalidate()
        timer = nil
    }
    
    public func firstAppear(stageNum: Int, zondRecovery: Int, beforeDisasterLeft: Int, completion: (()->Void)? = nil) {
        self.stageNum = stageNum
        self.zondRecovery = zondRecovery
        self.beforeDisasterLeft = beforeDisasterLeft
        self.completion = completion
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawFirstAppear), userInfo: nil, repeats: true)
    }
    

    @objc private func redrawFirstAppear(){
        checkPhase(direction: .plus, current: &startAnimation, step: 0.005, completion: completion)
    }
    
    
    public func hightlightTitle() {
       startSubtimer()
    }
    
    private func startTimer() {
       guard firstTime else { return }
       firstTime = false
       timer?.invalidate()
       timer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(self.startSubtimer), userInfo: nil, repeats: true)
    }
    
    
    @objc private func startSubtimer(){
        direction = direction == .plus ? .minus : .plus
        subtimer?.invalidate()
        subtimer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(self.redrawHighlightTitle), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawHighlightTitle(){
        checkPhase(direction: direction, current: &highlightTitle, step: 0.01)
    }
}
 

