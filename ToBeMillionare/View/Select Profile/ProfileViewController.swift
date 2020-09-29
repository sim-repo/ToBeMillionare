import UIKit

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var onboardHolo: OnboardHolo!
    
    @IBOutlet weak var onboardSpaceship1: OnboardSpaceship1_1!
    @IBOutlet weak var onboardSpaceship2: OnboardSpaceship2!
    @IBOutlet weak var onboardSpaceship3: OnboardSpaceship3!
    @IBOutlet weak var onboardMeteorit: OnboardMeteorit!
    @IBOutlet weak var onboardCosmos: OnboardCosmos!
    @IBOutlet weak var onboardExplosion: OnboardExplosion!
    
    
    
    var presenter: ViewableProfilePresenter {
        return PresenterFactory.shared.getPresenter(viewDidLoad: self) as! ViewableProfilePresenter
    }
    
    private var blinkingItemIdx: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
        runOnboardAnimation()
    }
    
    
    private func runOnboardAnimation() {
        
        
        // appear
        let p1_1: ((CGFloat)->Void) = { [weak self] moveToOnboard in
            guard let self = self else { return }
            self.onboardSpaceship1.redrawMoveToOnboard(moveToOnboard)
        }

        let p1_2: ((CGFloat)->Void) = { [weak self] moveToOnboard in
            guard let self = self else { return }
            self.onboardCosmos.redrawMoveToOnboard(moveToOnboard)
        }
        
        let phases1: [((CGFloat)->Void)] = [p1_1, p1_2]
        
        
        
        let pSpaceship1: ((CGFloat)->Void) = { [weak self] onboardAnimation in
            guard let self = self else { return }
            self.onboardSpaceship1.redrawOnboardAnimation(onboardAnimation)
        }
        
        let pSpaceship2: ((CGFloat)->Void) = { [weak self] onboardAnimation in
            guard let self = self else { return }
            self.onboardSpaceship2.redrawOnboardAnimation(onboardAnimation)
        }
        
        let pSpaceship3: ((CGFloat)->Void) = { [weak self] onboardAnimation in
            guard let self = self else { return }
            self.onboardSpaceship3.redrawOnboardAnimation(onboardAnimation)
        }
        
        let pCosmos: ((CGFloat)->Void) = { [weak self] onboardAnimation in
            guard let self = self else { return }
            self.onboardCosmos.redrawOnboardAnimation(onboardAnimation)
        }
        
        let phasesOnboardAnimation: [((CGFloat)->Void)] = [pSpaceship1, pSpaceship2, pSpaceship3, pCosmos]
        
        
    
        
        let p4: ((CGFloat)->Void) = { [weak self] onboardAnimation in
            guard let self = self else { return }
            self.onboardMeteorit.redrawOnboardAnimation(onboardAnimation)
        }
        
        let phases4: [((CGFloat)->Void)] = [p4, pSpaceship1]
        
        
        
        let p5_1: ((CGFloat)->Void) = { [weak self] discMove in
            guard let self = self else { return }
            self.onboardSpaceship2.redrawDiscMove1(discMove)
        }
        
        let p5_2: ((CGFloat)->Void) = { [weak self] discMove in
            guard let self = self else { return }
            self.onboardSpaceship2.redrawDiscMove2(discMove)
        }
        
        let p5_3: ((CGFloat)->Void) = { [weak self] discMove in
            guard let self = self else { return }
            self.onboardSpaceship2.redrawDiscMove3(discMove)
        }
        
        let p5_4: ((CGFloat)->Void) = { [weak self] discMove in
            guard let self = self else { return }
            self.onboardSpaceship2.redrawDiscMove4(discMove)
        }
        
        let p5_5: ((CGFloat)->Void) = { [weak self] indicators in
            guard let self = self else { return }
            self.onboardSpaceship2.redrawIndicators(indicators)
        }
        
        
        let p5_6: ((CGFloat)->Void) = { [weak self] towerLight in
            guard let self = self else { return }
            self.onboardSpaceship2.redrawTowerLight(towerLight)
        }
        
        let p5_7: ((CGFloat)->Void) = { [weak self] redCubeMove in
            guard let self = self else { return }
            self.onboardSpaceship2.redrawRedCubeMove(redCubeMove)
        }
        
        let p5_8: ((CGFloat)->Void) = { [weak self] redCubeMove in
            guard let self = self else { return }
            self.onboardSpaceship2.redrawRedCubeMove2(redCubeMove)
        }
        
        let p5_9: ((CGFloat)->Void) = { [weak self] redCubeMove in
            guard let self = self else { return }
            self.onboardSpaceship2.redrawRedCubeMove3(redCubeMove)
        }
        
        let p5_10: ((CGFloat)->Void) = { [weak self] arcMove in
            guard let self = self else { return }
            self.onboardSpaceship2.redrawArcMove1(arcMove)
        }
        
        
        let p5_11: ((CGFloat)->Void) = { [weak self] arcMove in
            guard let self = self else { return }
            self.onboardSpaceship2.redrawArcMove2(arcMove)
        }
        
        
        let p5_12: ((CGFloat)->Void) = { [weak self] arcMove in
            guard let self = self else { return }
            self.onboardSpaceship2.redrawArcMove3(arcMove)
        }
        
        
        let p5_13: ((CGFloat)->Void) = { [weak self] onboardingAnimation in
            guard let self = self else { return }
            self.onboardSpaceship2.redrawOnboardAnimation(onboardingAnimation)
        }
        
        let p5_14: ((CGFloat)->Void) = { [weak self] onboardingAnimation in
            guard let self = self else { return }
            self.onboardMeteorit.redrawOnboardAnimation(onboardingAnimation)
        }
        
        let p5_15: ((CGFloat)->Void) = { [weak self] onboardingAnimation in
            guard let self = self else { return }
            self.onboardExplosion.redrawOnboardAnimation(onboardingAnimation)
        }
        
        let p5_16: ((CGFloat)->Void) = { [weak self] arcMove in
            guard let self = self else { return }
            self.onboardSpaceship2.redrawArcMove4(arcMove)
        }
        

        
        let phases5: [((CGFloat)->Void)] = [p5_1, p5_2, p5_3, p5_4, p5_5, p5_6, p5_7, p5_8, p5_9, p5_10, p5_11, p5_12, p5_13, p5_14, p5_15, p5_16 ]
        
        
        let globalTimer: GlobalOnboardTimer = GlobalOnboardTimer()
        
        
        globalTimer.startAnimation(phase1Completions: phases1, phase2Completions: phasesOnboardAnimation, phase3Completions: phasesOnboardAnimation, phase4Completions: phases4, phase5Completions: phases5, phase6Completions: phasesOnboardAnimation, phase7Completions: phasesOnboardAnimation, phase8Completions: phasesOnboardAnimation, phase9Completions: phasesOnboardAnimation)
    }
    
    deinit {
        print("DEINIT: ProfileViewController")
    }
}


//MARK:- Collection Data Source

extension ProfileViewController: UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
        
        if let profile = presenter.getData(indexPath) {
            cell.setup(id: profile.getId(), name: profile.getName(), ava: profile.getAva())
            if blinkingItemIdx == indexPath.row {
                cell.blink()
            }
        }
        return cell
    }
}


//MARK:- Collection Flow Layout Delegate

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch ScreenResolutionsEnum.screen() {
        case .screen_47:
            return CGSize(width: 114, height: 200)
        case .screen_55:
            return CGSize(width: 114, height: 200)
        case .screen_58:
            return CGSize(width: 114, height: 200)
        case .screen_65:
            return CGSize(width: 114, height: 200)
        }
    }
}


//MARK:- Collection Data Delegate

extension ProfileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectProfile(indexPath)
    }
}


//MARK:- Presentable

extension ProfileViewController: PresentableProfileView {
    
    func performMainSegue() {
        performSegue(withIdentifier: "SegueMenu", sender: nil)
    }
    
    
    func performNewProfileSegue() {
        performSegue(withIdentifier: "SegueCreateProfile", sender: nil)
    }
    
    func blink(itemIdx: Int) {
        blinkingItemIdx = itemIdx
        let indexPath = IndexPath(item: itemIdx, section: 0)
        collectionView.performBatchUpdates({
            collectionView.reloadItems(at: [indexPath])
        }, completion: nil)
    }
}
