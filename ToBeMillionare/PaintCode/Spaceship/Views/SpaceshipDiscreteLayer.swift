import UIKit

class SpaceshipDiscreteView: UIView {
    
    
    enum Direction {
        case plus, minus
    }
    
    // timer vars:
    private var timer: Timer?
    
    
    // redraw vars:
    var wingsMove: CGFloat = 0.0
    var disc1PathOpacity: CGFloat = 0.0
    var disc1Move: CGFloat = 0.0
    var disc2PathOpacity: CGFloat = 0.0
    var disc2Move: CGFloat = 0.0
    var disc3PathOpacity: CGFloat = 0.0
    var disc3Move: CGFloat = 0.0
    var disc4PathOpacity: CGFloat = 0.0
    var disc4Move: CGFloat = 0.0
    var discPassLight1: CGFloat = 0.0
    var discPassLight2: CGFloat = 0.0
    var discPassLight3: CGFloat = 0.0
    var discPassLight4: CGFloat = 0.0
    
    var arc1Move: CGFloat = 0.0
    var arc2Move: CGFloat = 0.0
    var arc3Move: CGFloat = 0.0
    var arc4Move: CGFloat = 0.0
    
    var redCubeMove: CGFloat = 0.0
    var redCubePathOpacity: CGFloat = 0.0
    var redCube2Move: CGFloat = 0.0
    var redCubePath2Opacity: CGFloat = 0.0
    var redCube3PathOpacity: CGFloat = 0.0
    var redCube3Move: CGFloat = 0.0
    
    var onboardingIndicatorsOpacity: CGFloat = 0.0
    var towerLightOpacity: CGFloat = 0.0
    
    var antennaMove1: CGFloat = 0.0
    var antennaMove2: CGFloat = 0.0
    
    var rayOpacity: CGFloat = 0.0
    var circlesMove: CGFloat = 0.0
    var circlesLightMove: CGFloat = 0.99
    var spaceDustMove: CGFloat = 0.0
    
    // repeating
    private var timerCirclesLights: Timer?
    private var circlesDirection: Direction = .plus
    
    
    private var timerPathfinders: Timer?
    var disc1PathfinderDirection: Direction = .plus
    var disc2PathfinderDirection: Direction = .plus
    var disc3PathfinderDirection: Direction = .plus
    var disc4PathfinderDirection: Direction = .plus
    
    
    
    
    // operations:
    //          phase1:
    var phase1DiscPathfinder: (()->Void)?
    var phase1DiscGrab: (()->Void)?
    var phase1DiscPassLight: (()->Void)?
    var phase1Antenna1: (()->Void)?
    var phase1Antenna2: (()->Void)?
    var phase1HideDiscPathfinder: (()->Void)?
    
    //          phase2:
    var phase2DiscPathfinder: (()->Void)?
    var phase2DiscGrab: (()->Void)?
    var phase2DiscPassLight: (()->Void)?
    var phase2WingsMove: (()->Void)?
    var phase2HideDiscPathfinder: (()->Void)?
    
    //          phase3:
    var phase3DiscPathfinder: (()->Void)?
    var phase3DiscGrab: (()->Void)?
    var phase3DiscPassLight: (()->Void)?
    var phase3OnboardIndicators: (()->Void)?
    var phase3HideDiscPathfinder: (()->Void)?
    
    //          phase4:
    var phase4DiscPathfinder: (()->Void)?
    var phase4DiscGrab: (()->Void)?
    var phase4DiscPassLight: (()->Void)?
    var phase4TowerLightingOpacity: (()->Void)?
    var phase4HideDiscPathfinder: (()->Void)?
    
    //          phase5:
    var phase5ShowCubePathfinder: (()->Void)?
    var phase5CubeGrab: (()->Void)?
    var phase5HideCubePathfinder: (()->Void)?
    
    
    //          phase6:
    var phase6ShowCubePathfinder: (()->Void)?
    var phase6CubeGrab: (()->Void)?
    var phase6HideCubePathfinder: (()->Void)?
    
    
    //          phase7:
    var phase7ShowCubePathfinder: (()->Void)?
    var phase7CubeGrab: (()->Void)?
    var phase7HideCubePathfinder: (()->Void)?
    var phase7Arc1Move: (()->Void)?
    var phase7Arc2Move: (()->Void)?
    var phase7Arc3Move: (()->Void)?
    var phase7Arc4Move: (()->Void)?
    
    //          phase8:
    var phase8DiscPathfinders: (()->Void)?
    var phase8CircleMove: (()->Void)?
    var phase8CircleLight: (()->Void)?
    var phase8Ray: (()->Void)?
    var phase8SpaceDustMove: (()->Void)?
    
    
    var sequence: [(()->Void)?] = []
    var currOperationNum = -1
    
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        SpaceshipScreen.drawSpaceshipLoadingAnimationLayer2(
            frame: bounds,
            resizing: .aspectFit,
            spreadWings: wingsMove,
            disc1PathOpacity: disc1PathOpacity,
            disc1Move: disc1Move,
            disc2PathOpacity: disc2PathOpacity,
            disc2Move: disc2Move,
            disc3PathOpacity: disc3PathOpacity,
            disc3Move: disc3Move,
            disc4PathOpacity: disc4PathOpacity,
            disc4Move: disc4Move,
            arc1Move: arc1Move,
            arc2Move: arc2Move,
            arc3Move: arc3Move,
            arc4Move: arc4Move,
            circlesMove: circlesMove,
            redCubeMove: redCubeMove,
            redCubePathOpacity: redCubePathOpacity,
            redCube2Move: redCube2Move,
            redCubePath2Opacity: redCubePath2Opacity,
            button1Opacity: onboardingIndicatorsOpacity,
            towerLightOpacity: towerLightOpacity,
            rayOpacity: rayOpacity,
            redCube3PathOpacity: redCube3PathOpacity,
            redCube3Move: redCube3Move,
            discPassLight1: discPassLight1,
            discPassLight2: discPassLight2,
            discPassLight3: discPassLight3,
            discPassLight4: discPassLight4,
            antennaMove1: antennaMove1,
            antennaMove2: antennaMove2,
            spaceDustMove: spaceDustMove)
    }
    
    
    public func stop() {
        timer?.invalidate()
        timer = nil
    }
    
    
    private func gotoSequence(){
        if sequence.count - 1 > currOperationNum {
            currOperationNum += 1
            let operation = sequence[currOperationNum]
            operation?()
        }
    }
    
    
    private func checkPhase(direction: Direction = .plus, current: inout CGFloat, target: CGFloat, step: CGFloat) {
        
        if direction == .plus {
            if current < target {
                current += step
            }
        } else {
            if current > target {
                current -= step
            }
        }
        
        setNeedsDisplay()
        
        if target-step...target+step ~= current {
            timer?.invalidate()
            gotoSequence()
        }
    }
}


//MARK:- Phase 1:
extension SpaceshipDiscreteView {
    
    public func startAnimation(stage: Int) {

        switch stage {
        case 1:
            setupPhase1()
        case 2:
            setDonePhase1()
            setupPhase2()
        case 3:
            setDonePhase1()
            setDonePhase2()
            setupPhase3()
        case 4:
            setDonePhase1()
            setDonePhase2()
            setDonePhase3()
            setupPhase4()
        case 5:
            setDonePhase1()
            setDonePhase2()
            setDonePhase3()
            setDonePhase4()
            setupPhase5()
        case 6:
            setDonePhase1()
            setDonePhase2()
            setDonePhase3()
            setDonePhase4()
            setDonePhase5()
            setupPhase6()
        case 7:
            setDonePhase1()
            setDonePhase2()
            setDonePhase3()
            setDonePhase4()
            setDonePhase5()
            setDonePhase6()
            setupPhase7()
        case 8:
            setDonePhase1()
            setDonePhase2()
            setDonePhase3()
            setDonePhase4()
            setDonePhase5()
            setDonePhase6()
            setDonePhase7()
            startPhase8()
        default:
            break
        }
        self.setNeedsDisplay()
        gotoSequence()
    }
    
    
    private func setupPhase1() {
        phase1DiscPathfinder = { [weak self] in self?.startPhase1_1() }
        phase1DiscGrab = { [weak self] in self?.startPhase1_2() }
        phase1DiscPassLight = { [weak self] in self?.startPhase1_3() }
        phase1Antenna1 = { [weak self] in self?.startPhase1_4() }
        phase1Antenna2 = { [weak self] in self?.startPhase1_5() }
        phase1HideDiscPathfinder = { [weak self] in self?.startPhase1_6() }
        
        
        sequence.append(phase1DiscPathfinder)
        sequence.append(phase1DiscGrab)
        sequence.append(phase1DiscPassLight)
        sequence.append(phase1Antenna1)
        sequence.append(phase1Antenna2)
        sequence.append(phase1HideDiscPathfinder)
    }
    
    private func setDonePhase1() {
        disc1PathOpacity = 0
        discPassLight1 = 1
        disc1Move = 1
        antennaMove1 = 1
        antennaMove2 = 1
    }
    
    
    // disc pathfinder:
    private func startPhase1_1() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase1_1), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase1_1(){
        checkPhase(current: &disc1PathOpacity, target: 1.0, step: 0.1)
    }
    
    // disc grabbing:
    private func startPhase1_2() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase1_2), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase1_2(){
        checkPhase(current: &disc1Move, target: 1.0, step: 0.1)
    }
    
    // disc pass lighting:
    private func startPhase1_3() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase1_3), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase1_3(){
        checkPhase(current: &discPassLight1, target: 1.0, step: 0.1)
    }
    
    // antenna phase 1:
    private func startPhase1_4() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase1_4), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase1_4(){
        checkPhase(current: &antennaMove1, target: 1.0, step: 0.1)
    }
    
    // antenna phase 2:
    private func startPhase1_5() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase1_5), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase1_5(){
        checkPhase(current: &antennaMove2, target: 1.0, step: 0.1)
    }
    
    // hide disc pathfinder:
    private func startPhase1_6() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase1_6), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase1_6(){
        checkPhase(direction: .minus, current: &disc1PathOpacity, target: 0.0, step: 0.1)
    }
}


//MARK:- Phase 2:
extension SpaceshipDiscreteView {
    
    public func startPhase2() {
        setupPhase2()
        gotoSequence()
    }
    
    private func setupPhase2() {
        phase2DiscPathfinder = { [weak self] in self?.startPhase2_1() }
        phase2DiscGrab = { [weak self] in self?.startPhase2_2() }
        phase2DiscPassLight = { [weak self] in self?.startPhase2_3() }
        phase2WingsMove = { [weak self] in self?.startPhase2_4() }
        phase2HideDiscPathfinder = { [weak self] in self?.startPhase2_5() }
        
        sequence.append(phase2DiscPathfinder)
        sequence.append(phase2DiscGrab)
        sequence.append(phase2DiscPassLight)
        sequence.append(phase2WingsMove)
        sequence.append(phase2HideDiscPathfinder)
    }
    
    
    private func setDonePhase2() {
        disc2PathOpacity = 0
        discPassLight2 = 1
        disc2Move = 1
        wingsMove = 1
    }
    
    // disc pathfinder:
    private func startPhase2_1() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase2_1), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase2_1(){
        checkPhase(current: &disc2PathOpacity, target: 1.0, step: 0.1)
    }
    
    
    // disc grabbing:
    private func startPhase2_2() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase2_2), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase2_2(){
        checkPhase(current: &disc2Move, target: 1.0, step: 0.1)
    }
    
    
    // disc pass lighting:
    private func startPhase2_3() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase2_3), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase2_3(){
        checkPhase(current: &discPassLight2, target: 1.0, step: 0.1)
    }
    
    
    // wings:
    private func startPhase2_4() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase2_4), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase2_4(){
        checkPhase(current: &wingsMove, target: 1.0, step: 0.1)
    }
    
    // hide disc pathfinder:
    private func startPhase2_5() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase2_5), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase2_5(){
        checkPhase(direction: .minus, current: &disc2PathOpacity, target: 0.0, step: 0.1)
    }
}


//MARK:- Phase 3:
extension SpaceshipDiscreteView {
    
    public func startPhase3() {
        setupPhase3()
        gotoSequence()
    }
    
    private func setupPhase3() {
        phase3DiscPathfinder = { [weak self] in self?.startPhase3_1() }
        phase3DiscGrab = { [weak self] in self?.startPhase3_2() }
        phase3DiscPassLight = { [weak self] in self?.startPhase3_3() }
        phase3OnboardIndicators = { [weak self] in self?.startPhase3_4() }
        phase3HideDiscPathfinder = { [weak self] in self?.startPhase3_5() }
        
        sequence.append(phase3DiscPathfinder)
        sequence.append(phase3DiscGrab)
        sequence.append(phase3DiscPassLight)
        sequence.append(phase3OnboardIndicators)
        sequence.append(phase3HideDiscPathfinder)
    }
    
    
    private func setDonePhase3() {
        disc3Move = 1
        discPassLight3 = 1
        onboardingIndicatorsOpacity = 1
        disc3PathOpacity = 0
    }
    
    // disc pathfinder:
    private func startPhase3_1() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase3_1), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase3_1(){
        checkPhase(current: &disc3PathOpacity, target: 1.0, step: 0.1)
    }
    
    
    // disc grabbing:
    private func startPhase3_2() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase3_2), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase3_2(){
        checkPhase(current: &disc3Move, target: 1.0, step: 0.1)
    }
    
    
    // disc pass lighting:
    private func startPhase3_3() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase3_3), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase3_3(){
        checkPhase(current: &discPassLight3, target: 1.0, step: 0.1)
    }
    
    // onboarding indicators:
    private func startPhase3_4() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase3_4), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase3_4(){
        checkPhase(current: &onboardingIndicatorsOpacity, target: 1.0, step: 0.1)
    }
    
    // hide disc pathfinder:
    private func startPhase3_5() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase3_5), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase3_5(){
        checkPhase(direction: .minus, current: &disc3PathOpacity, target: 0.0, step: 0.1)
    }
}




//MARK:- Phase 4:
extension SpaceshipDiscreteView {
    
    public func startPhase4() {
        setupPhase4()
        gotoSequence()
    }
    
    private func setupPhase4() {
        phase4DiscPathfinder = { [weak self] in self?.startPhase4_1() }
        phase4DiscGrab = { [weak self] in self?.startPhase4_2() }
        phase4DiscPassLight = { [weak self] in self?.startPhase4_3() }
        phase4TowerLightingOpacity = { [weak self] in self?.startPhase4_4() }
        phase4HideDiscPathfinder = { [weak self] in self?.startPhase4_5() }
       
        sequence.append(phase4DiscPathfinder)
        sequence.append(phase4DiscGrab)
        sequence.append(phase4DiscPassLight)
        sequence.append(phase4TowerLightingOpacity)
        sequence.append(phase4HideDiscPathfinder)
        sequence.append(phase4HideDiscPathfinder)
    }
    
    private func setDonePhase4() {
        disc4PathOpacity = 0
        disc4Move = 1
        discPassLight4 = 1
        towerLightOpacity = 1
    }
    
    // show disc pathfinder:
    private func startPhase4_1() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase4_1), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase4_1(){
        checkPhase(current: &disc4PathOpacity, target: 1.0, step: 0.1)
    }
    
    
    // disc grabbing:
    private func startPhase4_2() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase4_2), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase4_2(){
        checkPhase(current: &disc4Move, target: 1.0, step: 0.1)
    }
    
    
    // disc pass lighting:
    private func startPhase4_3() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase4_3), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase4_3(){
        checkPhase(current: &discPassLight4, target: 1.0, step: 0.1)
    }
    
    
    // tower lighting:
    private func startPhase4_4() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase4_4), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase4_4(){
        checkPhase(current: &towerLightOpacity, target: 1.0, step: 0.1)
    }
    
    // hide disc pathfinder:
    private func startPhase4_5() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase4_5), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase4_5(){
        checkPhase(direction: .minus, current: &disc4PathOpacity, target: 0.0, step: 0.1)
    }
    
}


//MARK:- Phase 5:
extension SpaceshipDiscreteView {
    
    public func startPhase5() {
        setupPhase5()
        gotoSequence()
    }
    
    private func setupPhase5() {
        phase5ShowCubePathfinder = { [weak self] in self?.startPhase5_1() }
        phase5CubeGrab = { [weak self] in self?.startPhase5_2() }
        phase5HideCubePathfinder = { [weak self] in self?.startPhase5_3() }
        
        sequence.append(phase5ShowCubePathfinder)
        sequence.append(phase5CubeGrab)
        sequence.append(phase5HideCubePathfinder)
    }
    
    private func setDonePhase5() {
        redCubePathOpacity = 0
        redCubeMove = 1
    }
    
    
    // cube show pathfinder:
    private func startPhase5_1() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase5_1), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase5_1(){
        checkPhase(current: &redCubePathOpacity, target: 1.0, step: 0.1)
    }
    
    
    // cube grabbing:
    private func startPhase5_2() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase5_2), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase5_2(){
        checkPhase(current: &redCubeMove, target: 1.0, step: 0.1)
    }
    
    // cube hide pathfinder:
    private func startPhase5_3() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase5_3), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase5_3(){
        checkPhase(direction: .minus, current: &redCubePathOpacity, target: 0.0, step: 0.1)
    }
}


//MARK:- Phase 6:
extension SpaceshipDiscreteView {
    
    public func startPhase6() {
        setupPhase5()
        gotoSequence()
    }
    
    private func setupPhase6() {
        phase6ShowCubePathfinder = { [weak self] in self?.startPhase6_1() }
        phase6CubeGrab = { [weak self] in self?.startPhase6_2() }
        phase6HideCubePathfinder = { [weak self] in self?.startPhase6_3() }
        
        sequence.append(phase6ShowCubePathfinder)
        sequence.append(phase6CubeGrab)
        sequence.append(phase6HideCubePathfinder)
    }
    
    private func setDonePhase6() {
        redCubePath2Opacity = 0
        redCube2Move = 1
    }
    
    
    // show cube pathfinder:
    private func startPhase6_1() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase6_1), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase6_1(){
        checkPhase(current: &redCubePath2Opacity, target: 1.0, step: 0.1)
    }
    
    
    // cube grabbing:
    private func startPhase6_2() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase6_2), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase6_2(){
        checkPhase(current: &redCube2Move, target: 1.0, step: 0.1)
    }
    
    
    // hide cube pathfinder:
    private func startPhase6_3() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase6_3), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase6_3(){
        checkPhase(direction: .minus, current: &redCubePath2Opacity, target: 0.0, step: 0.1)
    }
    
    
    

}


//MARK:- Phase 7:
extension SpaceshipDiscreteView {
    
    public func startPhase7() {
        setupPhase7()
        gotoSequence()
    }
    
    private func setupPhase7() {
        phase7ShowCubePathfinder = { [weak self] in self?.startPhase7_1() }
        phase7CubeGrab = { [weak self] in self?.startPhase7_2() }
        phase7HideCubePathfinder = { [weak self] in self?.startPhase7_3() }
        phase7Arc1Move = { [weak self] in self?.startPhase7_4() }
        phase7Arc2Move = { [weak self] in self?.startPhase7_5() }
        phase7Arc3Move = { [weak self] in self?.startPhase7_6() }
        phase7Arc4Move = { [weak self] in self?.startPhase7_7() }
        
        
        sequence.append(phase7ShowCubePathfinder)
        sequence.append(phase7CubeGrab)
        sequence.append(phase7HideCubePathfinder)
        sequence.append(phase7Arc1Move)
        sequence.append(phase7Arc2Move)
        sequence.append(phase7Arc3Move)
        sequence.append(phase7Arc4Move)
    }
    
    private func setDonePhase7() {
        redCube3PathOpacity = 0
        redCube3Move = 1
        arc1Move = 1
        arc2Move = 1
        arc3Move = 1
        arc4Move = 1
    }
    
    
    // show cube pathfinder:
    private func startPhase7_1() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase7_1), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase7_1(){
        checkPhase(current: &redCube3PathOpacity, target: 1.0, step: 0.1)
    }
    
    
    // cube grabbing:
    private func startPhase7_2() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase7_2), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase7_2(){
        checkPhase(current: &redCube3Move, target: 1.0, step: 0.1)
    }
    
    
    // hide cube pathfinder:
    private func startPhase7_3() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase7_3), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase7_3(){
        checkPhase(direction: .minus, current: &redCube3PathOpacity, target: 0.0, step: 0.1)
    }
    
    // arc 1:
    private func startPhase7_4() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase7_4), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase7_4(){
        checkPhase(current: &arc1Move, target: 1.0, step: 0.1)
    }
    
    
    // arc 2:
    private func startPhase7_5() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase7_5), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase7_5(){
        checkPhase(current: &arc2Move, target: 1.0, step: 0.1)
    }
    
    
    // arc 3:
    private func startPhase7_6() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase7_6), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase7_6(){
        checkPhase(current: &arc3Move, target: 1.0, step: 0.1)
    }
    
    
    // arc 4:
    private func startPhase7_7() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase7_7), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase7_7(){
        checkPhase(current: &arc4Move, target: 1.0, step: 0.1)
    }
}




//MARK:- Phase 8:
extension SpaceshipDiscreteView {
    
    public func startPhase8() {
        setupPhase8()
        gotoSequence()
    }
    
    private func setupPhase8() {
     phase8Ray = { [weak self] in self?.startPhase8_1() }
     phase8CircleMove = { [weak self] in self?.startPhase8_2() }
     phase8SpaceDustMove = { [weak self] in self?.startPhase8_3() }
    
     sequence.append(phase8Ray)
     sequence.append(phase8CircleMove)
     sequence.append(phase8SpaceDustMove)
    }
    
    // ray:
    private func startPhase8_1() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase8_1), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase8_1(){
        checkPhase(current: &rayOpacity, target: 1.0, step: 0.1)
    }
    
    
    // circles move:
    private func startPhase8_2() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase8_2), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase8_2(){
        checkPhase(current: &circlesMove, target: 1.0, step: 0.1)
    }
    

    // circles dust:
    private func startPhase8_3() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase8_3), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase8_3(){
        checkPhase(current: &spaceDustMove, target: 1.0, step: 0.01)
    }
   
}
