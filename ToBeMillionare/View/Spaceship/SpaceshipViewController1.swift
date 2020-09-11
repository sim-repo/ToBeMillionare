//
//  SpaceshipViewController2.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 10.07.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

class SpaceshipViewController1: UIViewController {
    
    @IBOutlet weak var staticView: SpaceshipEnvStaticLayer!
    @IBOutlet weak var loadAnimationLayer: SpaceshipEnvLoadAnimationLayer!
    @IBOutlet weak var discreteAnimationLayer: SpaceshipEnvDiscreteAnimationLayer!
    @IBOutlet weak var smoothAnimationLayer: SpaceshipEnvSmoothAnimationLayer!
    @IBOutlet weak var spaceshipLayer: SpaceshipDiscreteView!
    @IBOutlet weak var spaceshipSmoothAnimationLayer: SpaceshipSmoothAnimationLayer!
    @IBOutlet weak var backMenuButton: BackButton!
    
   
    
    private var stage: Int = 0
    private var score: Double = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let completion: (()->Void)? = {[weak self] in
            guard let self = self else { return }
            self.loadAnimationLayer.startScoreAnimation(stage: self.stage, score: self.score)
        }
        loadAnimationLayer.startAnimation(completion: completion)
        discreteAnimationLayer.startAnimation()
        smoothAnimationLayer.startAnimation()
        spaceshipLayer.startAnimation(stage: stage)
        spaceshipSmoothAnimationLayer.startAnimation(stage: stage)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        backMenuButton.startAppear()
    }
    
    
    public func setup(stage: Int, score: Double) {
        self.score = score
        self.stage = stage
    }
    

    @IBAction func backMainMenu(_ sender: Any) {
        loadAnimationLayer.stop()
        discreteAnimationLayer.stop()
        smoothAnimationLayer.stop()
        spaceshipLayer.stop()
        spaceshipSmoothAnimationLayer.stop()
        backMenuButton.startDisappear() { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }
    }
}
