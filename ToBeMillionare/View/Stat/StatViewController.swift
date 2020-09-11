//
//  StatViewController.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 25.07.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

class StatViewController: UIViewController {

    @IBOutlet weak var statView: PlayStatView!
    
    private lazy var depo: Double = presenter.getDepo()
    
    
    private var presenter: ReadablePlayPresenter {
        let presenter: PlayPresenter = PresenterFactory.shared.getInstance()
        return presenter as ReadablePlayPresenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statView.setup(actualMoneyEnum: presenter.getActualCurrency(),
                       stageScoreAim: presenter.getStageAim(),
                       beforeDisasterLeft: presenter.getDaysLeftBeforeDisaster(),
                       depo: presenter.getDepo(),
                       zondRecovery: presenter.getZondRecovery(),
                       award: presenter.getAward(),
                       round: presenter.getRound().rawValue,
                       gamesCount: presenter.getGamesCount())
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        statView.start()
    }
    
    deinit {
        print("------------------DEINIT------------------")
        print("........StatViewController................")
        print("------------------------------------------")
    }
    
    @IBAction func pressOK(_ sender: Any) {
         self.presenter.gotoMainMenu(deepness: 3)
    }
}
