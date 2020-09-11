//
//  BackButton.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 06.08.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit


class BackButton: UIView {
    
    
    enum Direction {
        case plus, minus
    }
    
    
    // timer vars:
    private var timer: Timer?
    
    // redraw vars:
    private var hide: CGFloat = 0
    
    
    private var completion: (()->Void)? = nil
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        CommonKit.drawBackButton(frame: bounds, nextScreenOpacity: hide)
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
                timer = nil
                completion?()
            }
        } else {
            if target-step...target ~= current {
                current = target
                timer?.invalidate()
                timer = nil
                completion?()
            }
        }
    }
    
    
    public func startAppear(completion: (()->Void)? = nil) {
        guard timer == nil else { return }
        self.completion = completion
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawAppear), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawAppear(){
        checkPhase(direction: .plus, current: &hide, target: 1.0, step: 0.04, completion: completion)
    }
    
    
    public func startDisappear(completion: (()->Void)? = nil) {
        guard timer == nil else { return }
        self.completion = completion
        self.hide = 1
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawDisappear), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawDisappear(){
        checkPhase(direction: .minus, current: &hide, target: 0, step: 0.04, completion: completion)
    }
}
