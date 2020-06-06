//
//  TabBarView.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 04.06.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit


class TabBarView: UIView {

     override func draw(_ rect: CGRect) {
           let context = UIGraphicsGetCurrentContext()!
           
           layer.shadowColor = UIColor.black.cgColor
           layer.shadowOpacity = 1
           layer.shadowOffset = CGSize(width: 4, height: -10)
           layer.shadowRadius = 4
           layer.shouldRasterize = true //cache the rendered shadow
           
           let startPoint = CGPoint.zero
           let endPoint = CGPoint(x: 0, y: bounds.height)
           context.drawLinearGradient(TBMStyleKit.button_linear,
                                      start: startPoint,
                                      end: endPoint,
                                      options: [CGGradientDrawingOptions(rawValue: 0)])
       }

}
