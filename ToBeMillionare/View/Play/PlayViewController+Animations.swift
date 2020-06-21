//
//  PlayViewController + Presentable.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 21.06.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit



//MARK:- Animations

extension PlayViewController {
    
    internal func animateAuditoryClose() {
        hintBackgroundViewDownCon.isActive = false
        
        UIView.animate(withDuration: 1.0,
                       delay: 0.0,
                       options: [],
                       animations: {
                        self.hintBackgroundViewUpCon.isActive = true
                        self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    
    internal func animateOpenAnswer(left: BlockView, central: BlockView, right: BlockView, tintColorEnum: BlockView.TintColorEnum, _ completion: (()->Void)? = nil) {
        left.animateShowAnswer(tintColorEnum: tintColorEnum, completion: completion)
        central.animateShowAnswer(tintColorEnum: tintColorEnum)
        right.animateShowAnswer(tintColorEnum: tintColorEnum)
    }
    
    
    internal func animateBlink(left: BlockView, central: BlockView, right: BlockView, completion: (()->Void)? = nil ) {
        left.animateBlink(completion: completion)
        central.animateBlink()
        right.animateBlink()
    }
    
    
    
    
    
    internal func animateNextRound(){
        
        nextRoundBkgViewHideCon.isActive = false
        UIView.animate(withDuration: 0.1,
                       delay: 0.5,
                       animations: {
                        self.nextRoundBkgViewShowCon.isActive = true
                        self.view.layoutIfNeeded()
        }) {_ in
            
            self.nextRoundViewHideCon.isActive = false
            UIView.animate(withDuration: 0.1,
                           delay: 0.3,
                           animations: {
                            self.nextRoundViewShowCon.isActive = true
                            self.view.layoutIfNeeded()
            }) {_ in
                self.nextRoundView.shake() {
                    self.nextRoundViewShowCon.isActive = false
                    UIView.animate(withDuration: 0.1,
                                   delay: 0.5,
                                   animations: {
                                    self.nextRoundViewHideCon.isActive = true
                                    self.view.layoutIfNeeded()
                                    self.nextRoundBkgViewShowCon.isActive = false
                                    self.presenter.didNextLevelAnimated()
                                    
                    }) { _ in
                        UIView.animate(withDuration: 0.1,
                        delay: 0.3,
                        animations: {
                        
                        self.nextRoundBkgViewHideCon.isActive = true
                        self.view.layoutIfNeeded()
                        })
                    }
                }
            }
        }
    }
    
}
