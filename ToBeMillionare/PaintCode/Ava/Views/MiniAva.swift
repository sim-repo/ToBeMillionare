//
//  MiniAva.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 27.08.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//


import UIKit

// #0004
class MiniAva: UIView {

    // redraw vars:
    private var showStageScore: CGFloat = 0.0
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        AvaKit.drawMiniAva(frame: bounds, resizing: .aspectFit, showStageScore: showStageScore)
    }
    
    public func setup(currentStage: Int, depo: Double){
        showStageScore = CGFloat(MyConverter.stageToFraction(stage: currentStage, depo: depo))
        setNeedsDisplay()
    }
}
