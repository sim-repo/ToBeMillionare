//
//  SpaceshipViewController2.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 10.07.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

class SpaceshipViewController2: UIViewController {
    
    @IBOutlet weak var staticView: SpaceshipEnvStaticLayer!
    @IBOutlet weak var loadAnimationLayer: SpaceshipEnvLoadAnimationLayer!
    @IBOutlet weak var discreteAnimationLayer: SpaceshipEnvDiscreteAnimationLayer!
    @IBOutlet weak var smoothAnimationLayer: SpaceshipEnvSmoothAnimationLayer!
    @IBOutlet weak var spaceshipLayer: SpaceshipDiscreteView!
    @IBOutlet weak var spaceshipSmoothAnimationLayer: SpaceshipSmoothAnimationLayer!
    @IBOutlet weak var backMenuButton: BackButton!
    
    private var isFromMainMenu: Bool = false
    
    private var presenter: ReadablePlayPresenter {
        let presenter: PlayPresenter = PresenterFactory.shared.getInstance()
        return presenter as ReadablePlayPresenter
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let completion: (()->Void)? = {[weak self] in
            guard let self = self else { return }
            self.loadAnimationLayer.startScoreAnimation(stage: self.presenter.getStage(), score: self.presenter.getDepo())
        }
        loadAnimationLayer.startAnimation(completion: completion)
        discreteAnimationLayer.startAnimation()
        smoothAnimationLayer.startAnimation()
        spaceshipLayer.startAnimation(stage: presenter.getStage())
        spaceshipSmoothAnimationLayer.startAnimation(stage: presenter.getStage())
    }
    
    
    @IBAction func pressOK(_ sender: Any) {
        loadAnimationLayer.stop()
        discreteAnimationLayer.stop()
        smoothAnimationLayer.stop()
        spaceshipLayer.stop()
        spaceshipSmoothAnimationLayer.stop()
        self.presenter.gotoMainMenu(deepness: 2)
    }
}
