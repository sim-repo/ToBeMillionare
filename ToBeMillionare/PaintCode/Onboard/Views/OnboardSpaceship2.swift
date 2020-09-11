//
//  OnboardInstruction.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 31.08.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

//#0005
class OnboardSpaceship2: UIView {
    
    // redraw vars:
    var wingsMove: CGFloat = 1
    var disc1PathOpacity: CGFloat = 0
    var disc1Move: CGFloat = 1
    var disc2PathOpacity: CGFloat = 0
    var disc2Move: CGFloat = 1
    var disc3PathOpacity: CGFloat = 0
    var disc3Move: CGFloat = 1
    var disc4PathOpacity: CGFloat = 0
    var disc4Move: CGFloat = 1
    var discPassLight1: CGFloat = 0
    var discPassLight2: CGFloat = 0
    var discPassLight3: CGFloat = 0
    var discPassLight4: CGFloat = 0
    
    var arc1Move: CGFloat = 1
    var arc2Move: CGFloat = 1
    var arc3Move: CGFloat = 1
    var arc4Move: CGFloat = 1
    
    var redCubeMove: CGFloat = 1
    var redCubePathOpacity: CGFloat = 0
    var redCube2Move: CGFloat = 1
    var redCubePath2Opacity: CGFloat = 0
    var redCube3PathOpacity: CGFloat = 0
    var redCube3Move: CGFloat = 1
    
    var onboardingIndicatorsOpacity: CGFloat = 0
    var towerLightOpacity: CGFloat = 0
    
    var antennaMove1: CGFloat = 1
    var antennaMove2: CGFloat = 1
    
    var rayOpacity: CGFloat = 0
    var circlesMove: CGFloat = 1
    var circlesLightMove: CGFloat = 1
    var spaceDustMove: CGFloat = 1
    
    var moveToOnboard: CGFloat = 0
    var onboardAnimation: CGFloat = 0.0
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    
    override func draw(_ rect: CGRect) {
        
        OnboardKit.drawOnboardSpaceship2(frame: bounds,
                                              resizing: .aspectFill,
                                              spreadWings: wingsMove,
                                              disc1PathOpacity: disc1PathOpacity,
                                              disc1Move: disc1Move,
                                              disc2PathOpacity: disc2PathOpacity,
                                              disc2Move: disc2Move,
                                              disc3PathOpacity: disc3PathOpacity,
                                              disc3Move: disc3Move,
                                              disc4PathOpacity: disc4PathOpacity,
                                              disc4Move: disc4Move,
                                              arc1Move: arc1Move,
                                              arc2Move: arc2Move,
                                              arc3Move: arc3Move,
                                              arc4Move: arc4Move,
                                              circlesMove: circlesMove,
                                              redCubeMove: redCubeMove,
                                              redCubePathOpacity: redCubePathOpacity,
                                              redCube2Move: redCube2Move,
                                              redCubePath2Opacity: redCubePath2Opacity,
                                              button1Opacity: onboardingIndicatorsOpacity,
                                              towerLightOpacity: towerLightOpacity,
                                              rayOpacity: rayOpacity,
                                              redCube3PathOpacity: redCube3PathOpacity,
                                              redCube3Move: redCube3Move,
                                              discPassLight1: discPassLight1,
                                              discPassLight2: discPassLight2,
                                              discPassLight3: discPassLight3,
                                              discPassLight4: discPassLight4,
                                              antennaMove1: antennaMove1,
                                              antennaMove2: antennaMove2,
                                              spaceDustMove: spaceDustMove,
                                              onboardAnimation: onboardAnimation)
    }
}

//MARK:- Phases:
extension OnboardSpaceship2 {
    
    public func redrawOnboardAnimation(_ onboardAnimation: CGFloat) {
        guard onboardAnimation >= 0.8 && onboardAnimation <= 1.01 else { return }
        self.onboardAnimation = onboardAnimation
        setNeedsDisplay()
    }

    public func redrawDiscMove1(_ discMove: CGFloat) {
        self.disc1Move = discMove
    }
    
    public func redrawDiscMove2(_ discMove: CGFloat) {
        self.disc2Move = discMove
    }
    
    public func redrawDiscMove3(_ discMove: CGFloat) {
        self.disc3Move = discMove
    }
    
    public func redrawDiscMove4(_ discMove: CGFloat) {
        self.disc4Move = discMove
    }
    
    public func redrawIndicators(_ indicators: CGFloat) {
        self.onboardingIndicatorsOpacity = indicators
    }
    
    public func redrawTowerLight(_ towerLight: CGFloat) {
        self.onboardingIndicatorsOpacity = towerLight
    }
    
    public func redrawRedCubeMove(_ redCubeMove: CGFloat) {
        self.redCubeMove = redCubeMove
    }
    
    public func redrawRedCubeMove2(_ redCubeMove: CGFloat) {
        self.redCube2Move = redCubeMove
    }
    
    public func redrawRedCubeMove3(_ redCubeMove: CGFloat) {
        self.redCube3Move = redCubeMove
    }

    public func redrawArcMove1(_ arcMove: CGFloat) {
        self.arc1Move = arcMove
    }
    
    public func redrawArcMove2(_ arcMove: CGFloat) {
        self.arc2Move = arc1Move
    }
    
    public func redrawArcMove3(_ arcMove: CGFloat) {
        self.arc3Move = arc1Move
    }
    
    public func redrawArcMove4(_ arcMove: CGFloat) {
        self.arc4Move = arc1Move
     //   setNeedsDisplay()
    }
    
    public func needsRedraw() {
       // setNeedsDisplay()
    }
}
