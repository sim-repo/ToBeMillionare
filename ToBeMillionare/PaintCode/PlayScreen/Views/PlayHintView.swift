//
//  PlayCallFriendsView.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 22.07.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//


import UIKit


class PlayHintView: UIView {
    
    // timer vars:
    private var timer: Timer?
    
    
    // redraw vars:
    private var scale: CGFloat = 0.0
    private var opacity: CGFloat = 1.0
    private var completion: (()->Void)? = nil
    
    private var hintType: HintType = .auditory
    
    enum HintType {
        case auditory, phone, percent
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        switch hintType {
        case .auditory:
            PlayScreenV2.drawAuditoryIconView(frame: bounds, resizing: .aspectFit, hintScale: scale, hintOpacity: opacity)
        case .percent:
            PlayScreenV2.drawPercentsIconView(frame: bounds, resizing: .aspectFit, hintScale: scale, hintOpacity: opacity)
        case .phone:
            PlayScreenV2.drawPhoneIconView(frame: bounds, resizing: .aspectFit, hintScale: scale, hintOpacity: opacity)
        }
    }
    
    public func setup(hintType: HintType){
        self.hintType = hintType
        setNeedsDisplay()
    }
    
    public func startAnimate(completion: (()->Void)? = nil) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(self.redrawIcon), userInfo: nil, repeats: true)
        self.completion = completion
    }
    
    @objc private func redrawIcon(){
        

        if scale < 0.8 {
            scale += 0.01
        }
        
        if scale >= 0.8 {
            scale += 0.01 * 5 * (1.0 - scale)
        }
        
        if scale >= 0.99 {
            timer?.invalidate()
            opacity = 0.5
            completion?()
        }
        self.setNeedsDisplay()
    }
}
