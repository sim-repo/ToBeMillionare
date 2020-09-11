//
//  AppearedText.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 05.08.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit


class Curtain: UIView {
    
    
    enum Direction {
        case plus, minus
    }
    
    
    // timer vars:
    private var timer: Timer?
    
    // redraw vars:
    private var hide: CGFloat = 1
    private var buttonText: String = ""
    
    
    private var completion: (()->Void)? = nil
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        CommonKit.drawDisappearedButton(frame: bounds, nextScreenOpacity: hide, buttonText: buttonText)
    }
    
    public func setup(title: String) {
        buttonText = title
        setNeedsDisplay()
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
    
    
    public func startAppear(title: String, completion: (()->Void)? = nil) {
        guard timer == nil else { return }
        self.completion = completion
        buttonText = title
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
        checkPhase(direction: .minus, current: &hide, target: 0.01, step: 0.04, completion: completion)
    }
}
