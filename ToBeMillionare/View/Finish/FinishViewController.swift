//
//  FinishViewController.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 16.06.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

final class FinishViewController: UIViewController {
    
    
    @IBOutlet weak var waveBackgroundView: FinishWaveView!
    @IBOutlet weak var bottomBCQView: UIView!
    
    
    // Congrats:
    @IBOutlet weak var congratsView: UIView!
    @IBOutlet weak var congratsViewCenterXCon: NSLayoutConstraint!
    @IBOutlet weak var congratsViewLeadingCon: NSLayoutConstraint!
    @IBOutlet weak var nameFallingViewUpCon: NSLayoutConstraint!
    @IBOutlet weak var nameFallingViewDownCon: NSLayoutConstraint!
    @IBOutlet weak var scoreFallingLabelUpCon: NSLayoutConstraint!
    @IBOutlet weak var scoreFallingLabelDownCon: NSLayoutConstraint!
    
    @IBOutlet weak var scoreFallingLabel: UILabel!
    @IBOutlet weak var playerNameLabel: UILabel!
    
    @IBOutlet weak var dynamicFrameEdgesView: DynamicFrameEdgesView!
    
    private var presenter: ViewableFinishPresenter!
    private var allowGotoMenu = false
    
    lazy var particleEmitter: CAEmitterLayer = {
        let emitter = CAEmitterLayer()
        emitter.emitterShape = .point
        emitter.renderMode = .additive
        return emitter
    }()
    
    let starParticle = StarParticle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPresenter()
        setupOutlets()
        colorSetup()
        starsStartAnimate()
        congratsAnimate()
    }
    
    deinit {
        print("------------------DEINIT------------------")
        print("........FinishViewController................")
        print("------------------------------------------")
    }
    
    private func setupOutlets() {
        scoreFallingLabel.text = presenter.getAward()
        playerNameLabel.text = presenter.getPlayerName()
        dynamicFrameEdgesView.alpha = 0
    }
    
    
    private func setPresenter() {
        let p: FinishPresenter  = PresenterFactory.shared.getPresenter(viewDidLoad: self) as! FinishPresenter
        presenter = p as ViewableFinishPresenter
    }
    
    
    private func colorSetup(){
        let layer = CAGradientLayer()
        layer.frame = view.bounds
        layer.locations = [0.0, 0.6]
        layer.colors = [#colorLiteral(red: 0.1648972929, green: 0.1239107326, blue: 0.4854790568, alpha: 1).cgColor , #colorLiteral(red: 0.07960978895, green: 0.05893801898, blue: 0.2410279512, alpha: 1).cgColor]
        view.layer.insertSublayer(layer, at: 0)
        bottomBCQView.backgroundColor = TBMStyleKit.lighting
        bottomBCQView.fadeView(style: .top, percentage: 1.0)
    }
    
    
    @IBAction func pressBack(_ sender: Any) {
        guard allowGotoMenu else { return }
        gotoMainMenu()
    }
    
    
    // Inner Class
    class StarParticle: CAEmitterCell {
        public override init() {
            super.init()
            self.birthRate = 10
            self.lifetime = 10.0
            self.velocity = 100
            self.velocityRange = 50
            self.emissionLongitude = 90
            self.emissionRange = .pi
            self.spinRange = 5
            self.scale = 0.5
            self.scaleRange = 0.2
            self.alphaSpeed = -0.5
            self.contents = UIImage(named: "mystar")?.cgImage
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}


//MARK:- Sky Stars Animation
extension FinishViewController {
    private func starsStartAnimate(){
        waveBackgroundView.startAnimate()
    }
}

//MARK:- Congrats Animation
extension FinishViewController {
    
    private func showStars() {
        particleEmitter.emitterCells = [starParticle]
        particleEmitter.emitterPosition = CGPoint(x: view.frame.midX, y: view.frame.midY)
        self.view.layer.insertSublayer(particleEmitter, at: 2)
    }
    
    
    
    private func congratsAnimate(){
        congratsViewLeadingCon.isActive = false
        UIView.animate(withDuration: 0.1,
                       delay: 1.0,
                       animations: {
                        self.congratsViewCenterXCon.isActive = true
                        self.view.layoutIfNeeded()
                        
        }) {_ in
            self.congratsView.shake()
            self.nameFallingAnimate()
        }
    }
    
    
    private func nameFallingAnimate(){
        nameFallingViewUpCon.isActive = false
        
        UIView.animate(withDuration: 0.1,
                       delay: 1.0,
                       options: .curveEaseIn,
                       animations: {
                        self.nameFallingViewDownCon.isActive = true
                        self.view.layoutIfNeeded()
        },
                       completion: {_ in
                        self.scoreFallingAnimate()
                        self.dynamicFrameEdgesAnimate()
        })
    }
    
    private func dynamicFrameEdgesAnimate() {
        dynamicFrameEdgesView.alpha = 1
        dynamicFrameEdgesView.startAnimate()
    }
    
    private func scoreFallingAnimate() {
        scoreFallingLabelUpCon.isActive = false
        UIView.animate(withDuration: 0.1,
                       delay: 0.5,
                       animations: {
                        self.scoreFallingLabelDownCon.isActive = true
                        self.view.layoutIfNeeded()
        }) {_ in
            self.showStars()
            self.allowGotoMenu = true
        }
    }
}

//MARK:- Presentable
extension FinishViewController: PresentableFinishView {
    func gotoMainMenu() {
        let controllers = self.navigationController?.viewControllers
        for vc in controllers! {
            if vc is MenuViewController {
                _ = self.navigationController?.popToViewController(vc as! MenuViewController, animated: true)
            }
        }
    }
}
