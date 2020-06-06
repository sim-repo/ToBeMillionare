//
//  ScoreViewController.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 06.06.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {
    
    @IBOutlet weak var bottomBCQView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorSetup()
    }
    
    private func colorSetup(){
        view.backgroundColor = TBMStyleKit.mainBackground
        bottomBCQView.backgroundColor = TBMStyleKit.lighting
        bottomBCQView.fadeView(style: .top, percentage: 1.0)
    }

}
