//
//  SpaceshipEnvironment.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 10.07.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//


import UIKit


class ExtendedBarChartView: UIView {

    enum AvgBarChartEnum {
        case natural, percent
    }
    
    // control vars:
    private var isReady: Bool = true
    
    // timer vars:
    private var timer: Timer?
    
    
    // support vars:
    private let heightBarColumn: CGFloat = 190
    private var completion: (()->Void)? = nil
    private var curBarColumnIdx: Int = 0
    
    // redraw vars:
    private var days: [CGFloat] = Array(repeating: 0, count:30)
    private var targetDays: [CGFloat] = []
    private var barLineY: CGFloat = 0.0
    private var barLineX: CGFloat = 0.0
    private var barLineText: String = ""
    private var chartType: AvgBarChartEnum = .percent
    private var maxNaturalValue: CGFloat = 0
    private var isShowRemain: Bool = false
    private var axisTitle: String = ""
    private var axisText100: String = ""
    private var axisText50: String = ""
    private var targetLineY: CGFloat = 0.0
    
    enum Direction {
        case plus, minus
    }
    
    // phases:
    private var phase1: (()->Void)?
    private var phase2: (()->Void)?
    private var phase3: (()->Void)?
    
    private var sequence: [(()->Void)?] = []
    private var currOperationNum = -1
    
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    
    override func draw(_ rect: CGRect) {
        
        if ScreenResolutionsEnum.screen() == .screen_47 || ScreenResolutionsEnum.screen() == .screen_58 {
            ProgressScreen.drawExtendedBarChart_375(frame: bounds,
                                                    resizing: .aspectFit,
                                                    column1: days[0], column2: days[1], column3: days[2], column4: days[3], column5: days[4], column6: days[5], column7: days[6], column8: days[7], column9: days[8], column10: days[9], column11: days[10], column12: days[11], column13: days[12], column14: days[13], column15: days[14], column16: days[15], column17: days[16], column18: days[17], column19: days[18], column20: days[19], column21: days[20], column22: days[21], column23: days[22], column24: days[23], column25: days[24], column26: days[25], column27: days[26], column28: days[27], column29: days[28], column30: days[29],
                                                    barChartLineY: barLineY,
                                                    barChartLineX: barLineX,
                                                    barChartLineText: barLineText,
                                                    barChartAxisTitle: axisTitle,
                                                    barChartAxisText50: axisText50,
                                                    barChartAxisText100: axisText100)
            
        } else if ScreenResolutionsEnum.screen() == .screen_55 || ScreenResolutionsEnum.screen() == .screen_65{
            ProgressScreen.drawExtendedBarChart_414(frame: bounds,
                                                    resizing: .aspectFit,
                                                    column1: days[0], column2: days[1], column3: days[2], column4: days[3], column5: days[4], column6: days[5], column7: days[6], column8: days[7], column9: days[8], column10: days[9], column11: days[10], column12: days[11], column13: days[12], column14: days[13], column15: days[14], column16: days[15], column17: days[16], column18: days[17], column19: days[18], column20: days[19], column21: days[20], column22: days[21], column23: days[22], column24: days[23], column25: days[24], column26: days[25], column27: days[26], column28: days[27], column29: days[28], column30: days[29],
                                                    barChartLineY: barLineY,
                                                    barChartLineX: barLineX,
                                                    barChartLineText: barLineText,
                                                    barChartAxisTitle: axisTitle,
                                                    barChartAxisText50: axisText50,
                                                    barChartAxisText100: axisText100)
        }
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
                completion?()
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
    
    
    private func naturalPercentToChartY(_ naturalPercent: Double) -> CGFloat {
        return heightBarColumn * CGFloat(naturalPercent)/100
    }
    
    public func stop() {
        axisTitle = ""
        barLineText = ""
        axisText100 = ""
        axisText50 = ""
        barLineX = 0
        barLineY = 0
        isReady = true
        days = Array(repeating: 0, count: 30)
        timer?.invalidate()
        setNeedsDisplay()
    }
}


//MARK:- TARGET LINE: the target line is used instead of the average
// Target Line = 'TL'
extension ExtendedBarChartView {
    
    public func tl_startAnimation(axisTitle: String,
                                  axisText50: String,
                                  axisText100: String,
                                  targetLineText: String?,
                                  targetLineNaturalPercent: Double,
                                  naturalPercentPerDay: [Double],
                                  completion: (()->Void)?=nil) {
        
        guard isReady, naturalPercentPerDay.count > 0 else { return}
        isReady = false
        tl_reset()
        self.axisTitle = axisTitle
        self.axisText50 = axisText50
        self.axisText100 = axisText100
        self.barLineText = targetLineText ?? ""
        self.targetLineY = naturalPercentToChartY(targetLineNaturalPercent)
        self.completion = completion
        targetDays = naturalPercentPerDay.map{ naturalPercentToChartY($0) }
        setNeedsDisplay()
        setupPhases()
    }
    
    
    private func tl_reset() {
        curBarColumnIdx = 0
        targetDays.removeAll()
        days = Array(repeating: 0, count: 30)
    }
    
    
    private func setupPhases() {
        phase1 = { [weak self] in self?.startPhase1() }
        phase2 = { [weak self] in self?.startPhase2() }
        phase3 = { [weak self] in self?.startPhase3() }
        sequence.append(phase1)
        sequence.append(phase2)
        sequence.append(phase3)
        gotoSequence()
    }
    
    private func startPhase1() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase1), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawPhase1(){
        var direction: Direction = .minus
        if barLineY < targetLineY {
            direction = .plus
        }
        checkPhase(direction: direction, current: &barLineY, target: targetLineY, step: 5)
    }
    
    
    private func startPhase2() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase2), userInfo: nil, repeats: true)
    }
    
    
    @objc private func redrawPhase2(){
        checkPhase(direction: .plus, current: &barLineX, target: 1.0, step: 0.1)
    }
    
    
    @objc private func startPhase3(){
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.redrawPhase3), userInfo: nil, repeats: true)
    }
    
    @objc private func redrawPhase3(){
        runOnce(current: &days[curBarColumnIdx], target: targetDays[curBarColumnIdx], step: 20)
    }
}



//MARK:- FLOATING AVERAGE: used when it is necessary to show a floating average
extension ExtendedBarChartView {
    
    public func avg_startAnimation(axisText: String,
                                   axisText50: String,
                                   axisText100: String,
                                   naturalPercentPerDay: [Double],
                                   chartType: AvgBarChartEnum,
                                   maxNaturalValue: CGFloat? = 0,
                                   isShowRemain: Bool = false,
                                   completion: (()->Void)?=nil) {
        
        guard isReady, naturalPercentPerDay.count > 0 else { return}
        isReady = false
        avg_reset()
        
        self.axisTitle = axisText
        self.axisText50 = axisText50
        self.axisText100 = axisText100
        setNeedsDisplay()
        
        self.completion = completion
        
        targetDays = naturalPercentPerDay.map{naturalPercentToChartY($0)}
        self.chartType = chartType
        self.isShowRemain = isShowRemain
        if let val = maxNaturalValue {
            self.maxNaturalValue = val
        }
        avg_redrawTimer()
    }
    
    
    
    private func avg_reset() {
        axisTitle = ""
        axisText50 = ""
        axisText100 = ""
        chartType = .percent
        isShowRemain = false
        maxNaturalValue = 0
        curBarColumnIdx = 0
        targetDays.removeAll()
        days = Array(repeating: 0, count: 30)
    }
    
    
    @objc private func avg_redrawTimer(){
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.avg_redrawSubTimer), userInfo: nil, repeats: true)
    }
    
    
    @objc private func avg_redrawSubTimer(){
        runOnce(current: &days[curBarColumnIdx], target: targetDays[curBarColumnIdx], step: 20)
        let avg = days.filter{$0 > 0}.reduce(0, +) / CGFloat(curBarColumnIdx+1)
        
        switch chartType {
        case .natural:
            barLineText = avg_transformToNature(avg)
        case .percent:
            barLineText = avg_transformToPercent(avg)
        }
        barLineY = avg
    }
    
    
    private func avg_transformToNature(_ avgBarChartNumber: CGFloat) -> String {
        if isShowRemain {
            return "\(maxNaturalValue - (avgBarChartNumber/heightBarColumn * maxNaturalValue))"
        }
        return "\(Int(avgBarChartNumber/heightBarColumn * maxNaturalValue))"
    }
    
    
    private func avg_transformToPercent(_ avgBarChartNumber: CGFloat) -> String {
        return "\(Int(avgBarChartNumber/heightBarColumn * 100))%"
    }
}
