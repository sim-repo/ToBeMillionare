//
//  SolarSystemViewController.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 17.07.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

class SolarSystemViewController: UIViewController {

    @IBOutlet weak var solarSystemView: SolarSystemView!
    @IBOutlet weak var solarSystemHoloLayer: SolarSystemHoloLayer!
    @IBOutlet weak var asteroidLayer: SolarSystemAsteroidLayer!
    @IBOutlet weak var lightsLayer: SolarSystemLightsLayer!
    
    @IBOutlet weak var backMenuButton: BackButton!
    
    private var presenter: ReadablePlayPresenter {
        let presenter: PlayPresenter = PresenterFactory.shared.getInstance()
        return presenter as ReadablePlayPresenter
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        let completion7: (()->Void)? = { [weak self] in
            guard let self = self else { return }
            self.lightsLayer.startLightsShowAnimation()
        }
        
        let completion6: (()->Void)? = { [weak self] in
            guard let self = self else { return }
            self.asteroidLayer.startAsteroidMoveAnimation(daysBeforeDisaster: self.presenter.getDaysLeftBeforeDisaster(), completion: completion7)
        }
        
        
        let completion5: (()->Void)? = { [weak self] in
            guard let self = self else { return }
            self.solarSystemView.startSunAnimation(completion: completion6)
        }
        
        
        let completion4: (()->Void)? = { [weak self] in
            guard let self = self else { return }
            self.asteroidLayer.startAsteroidShowAnimation(completion: completion5)
        }
        
        let completion3: (()->Void)? = { [weak self] in
            guard let self = self else { return }
            self.solarSystemHoloLayer.startHoloPlanetsHideAnimation(completion: completion4)
        }
        
        let completion2: (()->Void)? = { [weak self] in
            guard let self = self else { return }
            self.asteroidLayer.startPathShowAnimation(completion: completion3)
        }
        
        let completion1: (()->Void)? = { [weak self] in
            guard let self = self else { return }
            self.solarSystemHoloLayer.startHoloPlanetsShowAnimation(completion: completion2)
        }
        solarSystemView.startBeginningAnimation(completion: completion1)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
           backMenuButton.startAppear()
    }
       
    
    @IBAction func doPressBack(_ sender: Any) {
        solarSystemView.stop()
        solarSystemHoloLayer.stop()
        asteroidLayer.stop()
        lightsLayer.stop()
        
        backMenuButton.startDisappear() { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}
