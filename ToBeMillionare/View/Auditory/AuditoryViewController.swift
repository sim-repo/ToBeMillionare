//
//  AuditoryViewController.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 23.07.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

class AuditoryViewController: UIViewController {

    @IBOutlet weak var barChart: PlayAuditoryBarChart!
    
    private var percentA: CGFloat = 0.0
    private var percentB: CGFloat = 0.0
    private var percentC: CGFloat = 0.0
    private var percentD: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        barChart.start(fractionPercentA: percentA,
                       fractionPercentB: percentB,
                       fractionPercentC: percentC,
                       fractionPercentD: percentD)
    }
    
    
    public func setup(percentA: CGFloat, percentB: CGFloat, percentC: CGFloat, percentD: CGFloat){
        self.percentA = percentA
        self.percentB = percentB
        self.percentC = percentC
        self.percentD = percentD
    }
    
    @IBAction func pressOK(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
