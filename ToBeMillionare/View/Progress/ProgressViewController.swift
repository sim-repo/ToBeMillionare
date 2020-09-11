//
//  ProgressViewController.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 20.07.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController {
    
    @IBOutlet weak var radarChartView: RadarChartView!
    
    @IBOutlet weak var greenMarkerView: MarkerView!
    @IBOutlet weak var blueMarkerView: MarkerView!
    @IBOutlet weak var redMarkerView: MarkerView!
    
    @IBOutlet weak var blueBarChart: BarChartView!
    @IBOutlet weak var greenBarChart: BarChartView!
    @IBOutlet weak var redBarChart: BarChartView!
    
    @IBOutlet weak var buttonOK: ProgressButtonOk!
    @IBOutlet weak var conTopButton: NSLayoutConstraint!
    @IBOutlet weak var conBottomExtendedBarChart: NSLayoutConstraint!
    
    @IBOutlet weak var conLeadingRadar: NSLayoutConstraint!
    @IBOutlet weak var conCenterRadar: NSLayoutConstraint!
    
    @IBOutlet weak var extendedBarChart: ExtendedBarChartView!
    @IBOutlet weak var extendedBarChartFrontLayer: ExtendedBarChartFrontLayer!
    
    @IBOutlet weak var topBonusIcon: BonusIcon!
    @IBOutlet weak var middleBonusIcon: BonusIcon!
    @IBOutlet weak var bottomBonusIcon: BonusIcon!
    
    @IBOutlet weak var topBonusView: BonusView!
    @IBOutlet weak var middleBonusView: BonusView!
    @IBOutlet weak var bottomBonusView: BonusView!
    
    
    private var presenter: ViewableProgressPresenter!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        presenter.viewWillAppear()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPresenter()
        startShowRadar()
        
        setupBarCharts()
        greenMarkerView.tryBlink(type: .green, delayBlink: 10.0)
        blueMarkerView.tryBlink(type: .blue, delayBlink: 11.0)
        redMarkerView.tryBlink(type: .red, delayBlink: 13.0)
    }
    
    
    deinit {
        print("------------------DEINIT------------------")
        print("........ProgressViewController................")
        print("------------------------------------------")
    }
    
    
    private func setupPresenter() {
        let p: ProgressPresenter  = PresenterFactory.shared.getPresenter(viewDidLoad: self) as! ProgressPresenter
        presenter = p as ViewableProgressPresenter
    }
    
    
    private func setupBarCharts() {
        startMiniRetension()
        startMiniSpeed()
        startMiniDegree()
    }
    
    
    @IBAction func pressOk(_ sender: Any) {
        startHideRadar()
    }
    
    private func stopAllAnimations() {
        topBonusView.stop()
        middleBonusView.stop()
        bottomBonusView.stop()
        topBonusIcon.stop()
        middleBonusIcon.stop()
        bottomBonusIcon.stop()
        greenMarkerView.stop()
    }
}



// MARK:- bonus
extension ProgressViewController {
    
    @IBAction func pressTopBonus(_ sender: Any) {
        topBonusIcon.didPress() { [weak self] in
            guard let self = self else { return }
            self.presenter.didPressBonusRetension()
        }
    }
    
    
    @IBAction func pressMiddleBonus(_ sender: Any) {
        middleBonusIcon.didPress() { [weak self] in
            guard let self = self else { return }
            self.presenter.didPressBonusSpeed()
        }
    }
    
    @IBAction func pressBottomBonus(_ sender: Any) {
        bottomBonusIcon.didPress() { [weak self] in
            guard let self = self else { return }
            self.presenter.didPressBonusDegree()
        }
    }
    
    private func startBonusAnimation(bonusText: String) {
        if topBonusView.startAnimation(bonusText) {
            return
        }
        
        if middleBonusView.startAnimation(bonusText) {
            return
        }
        
        if bottomBonusView.startAnimation(bonusText) {
            return
        }
    }
}


// MARK:- radar chart
extension ProgressViewController {
    
    private func startShowRadar() {
        conLeadingRadar.isActive = false
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .transitionCrossDissolve, animations: {
            self.conCenterRadar.isActive = true
            self.view.layoutIfNeeded()
        }, completion: {[weak self] _ in
            guard let self = self else { return }
            self.radarChartView.startAnimation(curRetension: self.presenter.radar_getCurrentRetension(), curDegree: self.presenter.radar_getCurrentDegree(), curSpeed: self.presenter.radar_getCurrentSpeed())
            
        })
    }
    
    
    private func startHideRadar() {
        self.buttonOK.press() { [weak self] in
            guard let self = self else { return }
            self.conCenterRadar.isActive = false
            UIView.animate(withDuration: 1.0, delay: 0.0, options: .transitionCrossDissolve, animations: {
                self.conLeadingRadar.isActive = true
                self.view.layoutIfNeeded()
            }, completion: {[weak self] _ in
                guard let self = self else { return }
                self.radarChartView.isHidden = true
                self.navigationController?.popViewController(animated: true)
            })
        }
    }
}


// MARK:- mini charts
extension ProgressViewController {
    
    private func startMiniRetension() {
        if let days = presenter.bar_getRetensionByDays() {
            let progress = presenter.bar_getCurrentRetension()
            greenBarChart.startAnimation(currentNaturalProgress: progress, naturalPercentPerDay: days, avgBarChartEnum: .usePredefinedValue, avgBarChartMaxNatural: 10)
        }
    }
    
    
    private func startMiniSpeed() {
        if let days = presenter.bar_getSpeedByDays() {
            let progress = presenter.bar_getCurrentSpeed()
            blueBarChart.startAnimation(currentNaturalProgress: progress, naturalPercentPerDay: days, avgBarChartEnum: .usePredefinedValue, avgBarChartMaxNatural: ROUND_TIME, isAvgBarChartShowRem: true)
        }
    }
    
    
    private func startMiniDegree() {
        if let days = presenter.bar_getDegreeByDays() {
            let progress = presenter.bar_getCurrentDegree()
            redBarChart.startAnimation(currentNaturalProgress: progress, naturalPercentPerDay: days, avgBarChartEnum: .usePredefinedValue, avgBarChartMaxNatural: 13)
        }
    }
}


// MARK:- extended charts
extension ProgressViewController {
    
    
    @IBAction func pressTopButton(_ sender: Any) {
        UIView.animateKeyframes(withDuration: 1.0, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/2, animations: {
                self.conBottomExtendedBarChart.constant = 0
                self.conTopButton.constant = -800
                self.view.layoutIfNeeded()
            })
        }, completion: {_ in
            self.startExtendedRetension()
        })
    }
    
    
    
    @IBAction func pressMiddleButton(_ sender: Any) {
        UIView.animateKeyframes(withDuration: 1.0, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/2, animations: {
                self.conBottomExtendedBarChart.constant = 0
                self.conTopButton.constant = -800
                self.view.layoutIfNeeded()
            })
        }, completion: {_ in
            self.startExtendedSpeed()
        })
    }
    
    
    @IBAction func pressBottomButton(_ sender: Any) {
        UIView.animateKeyframes(withDuration: 1.0, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/2, animations: {
                self.conBottomExtendedBarChart.constant = 0
                self.conTopButton.constant = -800
                self.view.layoutIfNeeded()
            })
        }, completion: {_ in
            self.startExtendedDegree()
        })
    }
    
    
    
    @IBAction func pressCloseExtendedBarChart(_ sender: Any) {
        UIView.animateKeyframes(withDuration: 1.0, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/2, animations: {
                self.conBottomExtendedBarChart.constant = 282
                self.conTopButton.constant = -42
                self.extendedBarChart.stop()
                self.extendedBarChartFrontLayer.stop()
                self.view.layoutIfNeeded()
            })
        }, completion: nil)
    }
    
    
    private func startExtendedRetension() {
        if let days = presenter.bar_getRetensionByDays() {
            
            let targetLineText = presenter.bar_getTargetLineText(achievementGroupEnum: .retension)
            let targetLineNaturalPercent = presenter.bar_getTargetLineY(achievementGroupEnum: .retension)
            
            extendedBarChart.tl_startAnimation(axisTitle: "кол-во игровых партий", axisText50: "5", axisText100: "10", targetLineText: targetLineText, targetLineNaturalPercent: targetLineNaturalPercent, naturalPercentPerDay: days) { [weak self] in
                guard let self = self else { return }
                self.extendedBarChartFrontLayer.startPeriodicity()
            }
        }
    }
    
    
    private func startExtendedSpeed() {
        if let days = presenter.bar_getSpeedByDays() {
            
            let targetLineText = presenter.bar_getTargetLineText(achievementGroupEnum: .speed)
            let targetLineNaturalPercent = presenter.bar_getTargetLineY(achievementGroupEnum: .speed)
            
            extendedBarChart.tl_startAnimation(axisTitle: "скорость ответа", axisText50: "50%", axisText100: "100%", targetLineText: targetLineText, targetLineNaturalPercent: targetLineNaturalPercent, naturalPercentPerDay: days) { [weak self] in
                guard let self = self else { return }
                self.extendedBarChartFrontLayer.startPeriodicity()
            }
            
            //            extendedBarChart.avg_startAnimation(axisText: "скорость ответа", axisText50: "50%", axisText100: "100%", naturalPercentPerDay: speed, avgBarChartEnum: .percent, avgBarChartMaxNatural: 60) { [weak self] in
            //                guard let self = self else { return }
            //                self.extendedBarChartFrontLayer.startPeriodicity()
            //            }
        }
    }
    
    
    private func startExtendedDegree() {
        if let days = presenter.bar_getDegreeByDays() {
            
            let targetLineText = presenter.bar_getTargetLineText(achievementGroupEnum: .degree)
            let targetLineNaturalPercent = presenter.bar_getTargetLineY(achievementGroupEnum: .degree)
            
            extendedBarChart.tl_startAnimation(axisTitle: "раунд", axisText50: "6", axisText100: "13", targetLineText: targetLineText, targetLineNaturalPercent: targetLineNaturalPercent, naturalPercentPerDay: days) { [weak self] in
                guard let self = self else { return }
                self.extendedBarChartFrontLayer.startPeriodicity()
            }
            
            //            extendedBarChart.avg_startAnimation(axisText: "уровень вопроса", axisText50: "6", axisText100: "13", naturalPercentPerDay: degree, avgBarChartEnum: .natural, avgBarChartMaxNatural: 13) { [weak self] in
            //                guard let self = self else { return }
            //                self.extendedBarChartFrontLayer.startPeriodicity()
            //            }
        }
    }
}


// MARK: - presentable
extension ProgressViewController: PresentableProgressView {
    
    func showRetensionIconBonus(hasBonus: Bool) {
        topBonusIcon.tryBlink(hasBonus: hasBonus)
    }
    
    
    func showSpeedIconBonus(hasBonus: Bool) {
        middleBonusIcon.tryBlink(hasBonus: hasBonus)
    }
    
    
    func showDegreeIconBonus(hasBonus: Bool) {
        bottomBonusIcon.tryBlink(hasBonus: hasBonus)
    }
    
    
    func startRetensionBonusAnimation(bonusText: String) {
        startBonusAnimation(bonusText: bonusText)
    }
    
    
    func startSpeedBonusAnimation(bonusText: String) {
         startBonusAnimation(bonusText: bonusText)
    }
    
    
    func startDegreeBonusAnimation(bonusText: String) {
         startBonusAnimation(bonusText: bonusText)
    }
}
