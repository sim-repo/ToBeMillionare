//
//  Label+Extensions.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 21.07.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

class ControlTitleLabel: UILabel {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    func commonInit(){
        self.textColor = .white
        self.font = UIFont(name: "Gilroy-Bold", size: 16)
        self.textAlignment = .left
    }
}


class ControlMediumLabel: UILabel {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    func commonInit(){
        self.textColor = .white
        self.font = UIFont(name: "Gilroy-Light", size: 12)
        self.textAlignment = .left
    }
}
