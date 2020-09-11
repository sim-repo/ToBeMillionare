//
//  SpaceshipEnvironment.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 10.07.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//


import UIKit


class BarChartView: UIView {
    
    
    // control vars:
    private var isReady: Bool = true
    
    // timer vars:
    private var timer: Timer?
    
    
    // redraw vars:
    private var days: [CGFloat] = Array(repeating: 0, count:30)
    private var barChartLineY: CGFloat = 0.0
    private var barChartLineText: String = ""
    private var diffPerDay: String = ""
    private var radioProgress: CGFloat = 0.0
    private var isDiffPositive: Bool = true
    private var targetDays: [CGFloat] = []
    private var targetRadioProgress: CGFloat = 0.0
    
    enum Direction {
        case plus, minus
    }
    
    // support vars:
    private let heightBarColumn: CGFloat = 40
    private var curBarColumnIdx: Int = 0
    private var avgBarChartEnum: AvgBarChartEnum = .percent
    private var avgBarChartMaxNatural: CGFloat = 0
    private var isAvgBarChartShowRem: Bool = false
    
    enum AvgBarChartEnum {
        case natural, percent, usePredefinedValue
    }
    
    // phases:
    private var phase1: (()->Void)?
    private var phase2: (()->Void)?
    
    private var phaseStep1: CGFloat = 0
    private var phaseStep2: CGFloat = 0
    
    private var sequence: [(()->Void)?] = []
    private var currOperationNum = -1
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        ProgressScreen.drawBarChart(frame: bounds,
                                    resizing: .aspectFill,
                                    column1: days[0], column2: days[1], column3: days[2], column4: days[3], column5: days[4], column6: days[5], column7: days[6], column8: days[7], column9: days[8], column10: days[9], column11: days[10], column12: days[11], column13: days[12], column14: days[13], column15: days[14], column16: days[15], column17: days[16], column18: days[17], column19: days[18], column20: days[19], column21: days[20], column22: days[21], column23: days[22], column24: days[23], column25: days[24], column26: days[25], column27: days[26], column28: days[27], column29: days[28], column30: days[29],
                                    barChartLineY: barChartLineY,
                                    barChartLineText: barChartLineText,
                                    diffPerDay: diffPerDay,
                                    isDiffPositive: isDiffPositive,
                                    radioProgress: radioProgress)
    }
    
    
    private func gotoSequence(){
        if sequence.count - 1 > currOperationNum {
            currOperationNum += 1
            let operation = sequence[currOperationNum]
            operation?()
        }
    }
    
    
    private func runOnce(current: inout CGFloat, target: CGFloat, step: CGFloat) {
        current += step
        setNeedsDisplay()
        if target...target+step ~= current {
            current = target
            if curBarColumnIdx >= targetDays.count - 1 {
                timer?.invalidate()
                isReady = true
            } else {
                curBarColumnIdx += 1
            }
        }
    }
    
    
    private func checkPhase(direction: Direction = .plus, current: inout CGFloat, target: CGFloat, step: CGFloat, completion: (()->Void)? = nil) {
        if direction == .plus {
            if current <= target {
                current += step
            }
        } else {
            if current > target {
                current -= step
            }
        }
        setNeedsDisplay()
        if direction == .plus {
            if target...target+step ~= current {
                current = target
                setNeedsDisplay()
                timer?.invalidate()
                completion?()
                gotoSequence()
            }
        } else {
            if target-step...target ~= current {
                current = target
                setNeedsDisplay()
                timer?.invalidate()
                completion?()
                gotoSequence()
            }
        }
    }
    
    
    public func startAnimation(currentNaturalProgress: Double,
                               naturalPercentPerDay: [Double],
                               avgBarChartEnum: AvgBarChartEnum,
                               avgBarChartMaxNatural: Double? = 0,
                               isAvgBarChartShowRem: Bool = false ) {
        
        guard naturalPercentPerDay.count > 0 else { return }
        guard isReady else { return }
        isReady = false
        
        reset()
        
        targetRadioProgress = CGFloat(currentNaturalProgress * 0.01) // 100% = 1
        targetDays = naturalPercentPerDay.map{transformToBarColumn($0)}
        self.avgBarChartEnum = avgBarChartEnum
        self.isAvgBarChartShowRem = isAvgBarChartShowRem
        if let natural = avgBarChartMaxNatural {
            self.avgBarChartMaxNatural = CGFloat(natural)
        }
        setupTiming()
        setupPhases()
    }
    
    
    private func setupPhases() {
        phase1 = { [weak self] in self?.startPhase1() }
        phase2 = { [weak self] in self?.startPhase2() }
        sequence.append(phase1)
        sequence.append(phase2)
        gotoSequence()
    }
    
    
    private func reset() {
        avgBarChartEnum = .percent
        isAvgBarChartShowRem = false
        avgBarChartMaxNatural = 0
        curBarColumnIdx = 0
        targetDays.removeAll()
        days = Array(repeating: 0, count: 30)
    }
    
    //MARK:- Timing:
    private func setupTiming(){
       if targetRadioProgress < 0.2 {
            phaseStep1 = 0.001
       } else {
            phaseStep1 = 0.01
        }
       phaseStep2 = 1
    }
    
    
    @objc private func startPhase1(){
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase1), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawPhase1(){
        checkPhase(current: &radioProgress, target: targetRadioProgress, step: phaseStep1)
        updateRadioTitle(number: radioProgress)
    }
    
    
    private func startPhase2() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase2), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawPhase2(){
        
        runOnce(current: &days[curBarColumnIdx], target: targetDays[curBarColumnIdx], step: phaseStep2)
        
        let avg = days.filter{$0 > 0}.reduce(0, +) / CGFloat(curBarColumnIdx+1)
        if avgBarChartEnum == .natural || avgBarChartEnum == .percent {
            avg_updateRadioTitle(avg: avg)
        }
        
        if curBarColumnIdx > 0 {
            let prev = targetDays[curBarColumnIdx-1]
            let cur = targetDays[curBarColumnIdx]
            isDiffPositive = true
            diffPerDay = ""
            if prev > 0 && cur > 0{
                let diff = ((cur - prev) / prev)*100
                let round = Int(diff.rounded(.toNearestOrEven))
                isDiffPositive = diff >= 0
                diffPerDay = (isDiffPositive ? "+" : "") + "\(round)%"
            }
        }
        barChartLineY = avg
    }
}



// average
extension BarChartView {
    
    private func avg_updateRadioTitle(avg: CGFloat){
        switch avgBarChartEnum {
               case .natural:
                   barChartLineText = transformToNature(avg)
               case .percent:
                   barChartLineText = transformToPercent(avg)
               default:
                    break
        }
    }
    
    private func updateRadioTitle(number: CGFloat){
        guard avgBarChartEnum == .usePredefinedValue else { return }
        barChartLineText = "\(Int(number*100))"
        radioProgress = number
    }
}


// transformation
extension BarChartView {
    
    
    private func transformToBarColumn(_ naturalPercentPerDay: Double) -> CGFloat {
        return heightBarColumn * CGFloat(naturalPercentPerDay)/100
    }
    
    
    private func transformToNature(_ avgBarChartNumber: CGFloat) -> String {
        if isAvgBarChartShowRem {
            return "\(Int(avgBarChartMaxNatural - (avgBarChartNumber/heightBarColumn * avgBarChartMaxNatural)))"
        }
        return "\(Int(avgBarChartNumber/heightBarColumn * avgBarChartMaxNatural))"
    }
    
    
    private func transformToPercent(_ avgBarChartNumber: CGFloat) -> String {
        return "\(Int(avgBarChartNumber/heightBarColumn * 100))"
    }
}


