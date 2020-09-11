//
//  SpaceshipEnvironment.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 10.07.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//


import UIKit


class RadarChartView: UIView {
    
    // timer vars:
    private var timer: Timer?
    
    // redraw vars:
    private var retension: CGFloat = 0.0
    private var degree: CGFloat = 0.0
    private var speed: CGFloat = 0.0
    
    private var targetRetension: CGFloat = 0.0
    private var targetDegree: CGFloat = 0.0
    private var targetSpeed: CGFloat = 0.0
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        if ScreenResolutionsEnum.screen() == .screen_47 {
            ProgressScreen.drawRadarChart_Screen47(frame: bounds,
                                          resizing: .aspectFit,
                                          retension: retension,
                                          degree: degree,
                                          speed: speed)
        } else {
            ProgressScreen.drawRadarChart_ScreenAll(frame: bounds,
                                          resizing: .aspectFit,
                                          retension: retension,
                                          degree: degree,
                                          speed: speed)
            
        }
    }
    
    private func runOnce(timer: Timer, step: CGFloat) {
        
        if retension < targetRetension {
            retension += step
        }
        
        if degree < targetDegree {
            degree += step
        }
        
        if speed < targetSpeed {
            speed += step
        }
        
        self.setNeedsDisplay()
        
        let max1 = max(targetRetension, targetDegree, targetSpeed)
        let max2 = max(retension, degree, speed)
        
        if max1...max1+step ~= max2 {
            timer.invalidate()
        }
    }
    
    
    public func startAnimation(curRetension: Double, curDegree: Double, curSpeed: Double) {
        self.targetRetension = CGFloat(curRetension == 0 ? 0.02: curRetension)
        self.targetDegree = CGFloat(curDegree == 0 ? 0.02: curDegree)
        self.targetSpeed = CGFloat(curSpeed == 0 ? 0.02: curSpeed)
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawTimer(){
        guard let timer = timer else { return }
        runOnce(timer: timer, step: 0.001)
    }
}




