//
//  PlayOkButtonView.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 22.07.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit


class PlayCounterView: UIView {
    
    // timer vars:
    private var timer: Timer?
    
    
    // redraw vars:
    private var counterNumber: CGFloat = 0.0
    
    private var completion: (()->Void)? = nil
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        PlayScreenV2.drawCounterView(frame: bounds, resizing: .aspectFit, counterNumber: counterNumber)
    }
    
    
    public func start(completion: (()->Void)? = nil) {
        counterNumber = 0
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.redraw), userInfo: nil, repeats: true)
        self.completion = completion
    }
    
    public func stop() -> Int {
        timer?.invalidate()
        let spentTime = Int(counterNumber / CGFloat(6.0))
        counterNumber = 0
        return spentTime
    }
    
    public func reset() {
        counterNumber = 0
        setNeedsDisplay()
    }
    
    
    @objc private func redraw(){
        if counterNumber <= 360 {
            counterNumber += 6.0
        }
        
        if counterNumber >= 360 {
            timer?.invalidate()
            completion?()
        }
        self.setNeedsDisplay()
    }
}
