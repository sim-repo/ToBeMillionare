//
//  GameOverViewController.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 18.06.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {

  
    @IBOutlet var bkgView: UIView!
    @IBOutlet weak var label: UILabel!
    
    private var playPresenter: ReadablePlayPresenter {
        let presenter: PlayPresenter = PresenterFactory.shared.getInstance()
        return presenter as ReadablePlayPresenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        print("------------------DEINIT------------------")
        print("........GameOverViewController................")
        print("------------------------------------------")
    }
    
    @IBAction func pressBackMenu(_ sender: Any) {
        bkgView.backgroundColor = .black
        label.isHidden = true
        self.performSegue(withIdentifier: "SegueStat", sender:  nil)
    }
}
