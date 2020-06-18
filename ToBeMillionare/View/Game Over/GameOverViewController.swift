//
//  GameOverViewController.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 18.06.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {

    private var playPresenter: ReadablePlayPresenter {
        let presenter: PlayPresenter = PresenterFactory.shared.getInstance()
        return presenter as ReadablePlayPresenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func pressBackMenu(_ sender: Any) {
        dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            self.playPresenter.gotoMainMenu()
        }
    }
}
