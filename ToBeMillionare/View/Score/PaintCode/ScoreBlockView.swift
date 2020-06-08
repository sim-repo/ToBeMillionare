//
//  ScoreWaveView.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 06.06.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

protocol RobotCompatibleProtocolDelegate {
    func didPut()
    func didTake()
}

class ScoreBlockView: UIView {

    private var scoreBlockOpacity: CGFloat = 0
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        TBMStyleKit.drawScoreBlock(frame: bounds, resizing: .stretch, scoreBlockOpacity: scoreBlockOpacity)
    }
    
    public func setOpacity(enable: CGFloat) {
        scoreBlockOpacity = enable
        setNeedsDisplay()
    }
}

extension ScoreBlockView: RobotCompatibleProtocolDelegate {
    func didPut() {
        setOpacity(enable: 1)
    }
    
    func didTake() {
        setOpacity(enable: 0)
    }
}
