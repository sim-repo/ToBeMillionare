//
//  StageViewController.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 02.08.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

class StageViewController: UIViewController {

    @IBOutlet weak var bkgLayer: StageBkgLayer!
    @IBOutlet weak var moneyGroupLayer: StageMoneyGroupLayer!
    @IBOutlet weak var dataLayer: StageDataLayer!
    
    @IBOutlet weak var conBottomOkButton: NSLayoutConstraint!
    
    private var presenter: ReadablePlayPresenter {
        let presenter: PlayPresenter = PresenterFactory.shared.getInstance()
        return presenter as ReadablePlayPresenter
    }
    
    private var stageNum: Int = 0
    private var zondRecovery: Int = 0
    private var daysBeforeDisaster: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        dataLayer.firstAppear(stageNum: stageNum, zondRecovery: zondRecovery, beforeDisasterLeft: daysBeforeDisaster) { [weak self] in
            guard let self = self else { return }
            self.bkgLayer.startSpotlight()
            self.dataLayer.hightlightTitle()
            self.moneyGroupLayer.startHighlight()
        }
    }
    
    
    public func setup(stageNum: Int, zondRecovery: Int, daysBeforeDisaster: Int) {
        self.stageNum = stageNum
        self.zondRecovery = zondRecovery
        self.daysBeforeDisaster = daysBeforeDisaster
    }
    
    
    private func setupLayout() {
        if ScreenResolutionsEnum.screen() == .screen_47 {
            conBottomOkButton.constant = 4
        } else if ScreenResolutionsEnum.screen() == .screen_55 {
            conBottomOkButton.constant = 16
        }
        else {
            conBottomOkButton.constant = 16
        }
    }
    
    
    @IBAction func pressOK(_ sender: Any) {
        performSegue(withIdentifier: "SegueSpaceship", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        bkgLayer.stop()
        dataLayer.stop()
        moneyGroupLayer.stop()
    }
}
