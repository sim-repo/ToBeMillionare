//
//  QuestionView.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 22.07.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//


import UIKit


class PlayQuestionView: UIView {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        PlayScreenV2.drawQuestionView(frame: bounds)
    }
}


