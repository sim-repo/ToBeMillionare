//
//  SpaceshipEnvironment.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 10.07.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//


import UIKit


class ExtendedBarChartFrontLayer: UIView {
    
    // control vars:
    private var isReady: Bool = true
    
    // timer vars:
    private var timer: Timer?
    private var subtimer: Timer?
    
    // redraw vars:
    private var reflection: CGFloat = 0
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    
    override func draw(_ rect: CGRect) {
        ProgressScreen.drawExtendedBarChart_FrontLayer(frame: bounds, resizing: .aspectFit, reflection: reflection)
    }
    
    
    public func startPeriodicity() {
        runPeriodicity()
    }
    
    public func stop() {
        isReady = true
        timer?.invalidate()
        subtimer?.invalidate()
        reflection = 0
        setNeedsDisplay()
    }
    
    
    private func restartPeriodicity() {
        guard isReady else { return }
        isReady = false
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(self.runPeriodicity), userInfo: nil, repeats: true)
    }
    
    
    @objc private func runPeriodicity(){
        reflection = 0
        subtimer?.invalidate()
        subtimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(self.redrawPeriodicity), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawPeriodicity(){
        checkPeriodicity(current: &reflection, step: 0.03)
    }
    
    
    private func checkPeriodicity(current: inout CGFloat, step: CGFloat) {
        current += step
        self.setNeedsDisplay()
        if 1...1+step ~= current {
            current = 1
            setNeedsDisplay()
            subtimer?.invalidate()
            restartPeriodicity()
        }
    }
}
