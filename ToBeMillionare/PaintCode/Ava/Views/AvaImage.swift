//
//  AvaImage.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 29.08.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

// #0004
class AvaImage: UIView {
    
    enum BlinkType{
        case tv,line
    }
    
    // control vars
    private var isReadyBlink: Bool = true
    
    // timer vars:
    private var timer: Timer?
    
    // redraw vars:
    private var drawingImage: URL!
    private var userName: String!
    private var blink: CGFloat = 0.0
    private var blink2: CGFloat = 0.0
    
    private var blinkType: BlinkType = .tv
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        AvaKit.drawAvaImage(frame: bounds, resizing: .aspectFit, userName: userName, blinkMove: blink, blinkMove2: blink2, drawingImage: drawingImage)
    }
    
    public func setup(drawingImage: URL, userName: String){
        self.drawingImage = drawingImage
        self.userName = userName
        setNeedsDisplay()
    }
    
    public func stop() {
        blink = 0
        blink2 = 0
        isReadyBlink = true
        setNeedsDisplay()
        timer?.invalidate()
    }
}



// MARK:- Blink
extension AvaImage {
    
    public func tryBlink(){
        guard isReadyBlink else { return }
        isReadyBlink = false
        startBlink()
    }
    
    @objc private func startBlink() {
        blink = 0
        blink2 = 0
        blinkType = blinkType == .tv ? .line : .tv
        timer?.invalidate()
        var interval: TimeInterval!
        switch blinkType {
        case .tv:
            interval = 0.1
        case .line:
            interval = 0.04
        }
        interval = 0.04
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(self.redrawBlink), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawBlink(){
        checkPeriodicity(current: &blink2, step: 0.1) // 0.1
        checkPeriodicity2(current: &blink, step: 0.1)
    }
    
    private func checkPeriodicity(current: inout CGFloat, step: CGFloat) {
        current += step
        setNeedsDisplay()
        if 1...1+step ~= current {
            current = 1
            setNeedsDisplay()
            isReadyBlink = true
            timer?.invalidate()
        }
    }
    
    private func checkPeriodicity2(current: inout CGFloat, step: CGFloat) {
        current += step
        setNeedsDisplay()
        if 1...1+step ~= current {
            current = 1
            setNeedsDisplay()
        }
    }
}



