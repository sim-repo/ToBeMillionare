//
//  PlayButtonView.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 22.07.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit


class StageBkgLayer: UIView {
    
    enum Direction {
        case plus, minus
    }
    
    
    // timer vars:
    private var timer: Timer?
    private var subtimer: Timer?
    
    
    // control vars:
    private var spotlightMove: CGFloat = 0
    
    private var direction: Direction = .plus
    
    private func checkPhase(direction: inout Direction, current: inout CGFloat, step: CGFloat) {
        
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
                direction = .minus
            }
        } else {
            if -step...0.0 ~= current {
                current = 0.0
                setNeedsDisplay()
                direction = .plus
            }
        }
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    
    override func draw(_ rect: CGRect) {
        if ScreenResolutionsEnum.screen() == .screen_47 {
            NextStageKit.drawSpotlightLayer_47(frame: bounds, resizing: .aspectFit, spotlightMove: spotlightMove)
        } else if ScreenResolutionsEnum.screen() == .screen_55 {
            NextStageKit.drawSpotlightLayer_55(frame: bounds, resizing: .aspectFit, spotlightMove: spotlightMove)
        } else if ScreenResolutionsEnum.screen() == .screen_58 {
            NextStageKit.drawSpotlightLayer_58(frame: bounds, resizing: .aspectFit, spotlightMove: spotlightMove)
        } else if ScreenResolutionsEnum.screen() == .screen_65 {
            NextStageKit.drawSpotlightLayer_65(frame: bounds, resizing: .aspectFit, spotlightMove: spotlightMove)
        }
    }
    
    public func stop() {
        timer?.invalidate()
        timer = nil
        subtimer?.invalidate()
        subtimer = nil
    }

    public func startSpotlight() {
        subtimer?.invalidate()
        subtimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.redrawSpotlight), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawSpotlight(){
        checkPhase(direction: &direction, current: &spotlightMove, step: 0.01)
    }
}
 

