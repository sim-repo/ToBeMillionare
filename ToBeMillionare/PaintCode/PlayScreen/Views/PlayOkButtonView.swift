//
//  PlayOkButtonView.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 22.07.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit


class PlayOkButtonView: UIView {

    // timer vars:
    private var timer: Timer?
    
    private var isPressed = false
    private var completion: (()->Void)?
    private var count = 0
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        if isPressed {
            PlayScreenV2.drawOkPressedButtonView(frame: bounds)
        } else {
            PlayScreenV2.drawOkButtonView(frame: bounds)
        }
    }
    
    public func press(completion: (()->Void)? = nil) {
        count = 0
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(self.redraw), userInfo: nil, repeats: true)
        self.completion = completion
    }
    
    @objc private func redraw(){
        print("PlayOkButtonView")
        isPressed = count == 0
        self.setNeedsDisplay()
        if !isPressed {
            timer?.invalidate()
            completion?()
        }
        count += 1
    }
}
