//
//  ProgressPresenter.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 07.08.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import Foundation

final class ProgressPresenter {
    internal weak var vc: PresentableProgressView?
    private let tail: Double = 1 //+1%
    
    private func calcPercentUsedDays(completedDays: Double) -> Double {
        let percent = completedDays/Double(ACHIEVEMENT_PERIOD_IN_DAYS)*100
        return percent
    }
}

// MARK:- Bonus
extension ProgressPresenter {
    
    private func calcBonus(reason: BonusReasonEnum) {
        
        let currency: CurrencyEnum = CurrencyEnum.getCurrency(stage: ProfileService.getForcedSelected().getStage())
        
        switch reason {
            case .dailyRetension:
                if let days = ProfileService.achievementService.getAvgRetentionByDays() {
                    let _ = ProfileService.bonusService.calcBonus(avgBySerialDays: days, bonusReasonEnum: .dailyRetension, actualCurrency: currency)
                }
            case .dailySpeed:
                if let days = ProfileService.achievementService.getAvgSpeedByDays() {
                    let _ = ProfileService.bonusService.calcBonus(avgBySerialDays: days, bonusReasonEnum: .dailySpeed, actualCurrency: currency)
                }
            case .dailyDegree:
                if let days = ProfileService.achievementService.getAvgDegreeByDays() {
                    let _ = ProfileService.bonusService.calcBonus(avgBySerialDays: days, bonusReasonEnum: .dailyDegree, actualCurrency: currency)
                }
            case .none:
                fatalError("ProgressPresenter: calcBonus: enum .none detected!")
        }
    }
    
    private func hasDailyBonus(reason: BonusReasonEnum) -> Bool {
        switch reason {
            case .dailyRetension:
                return ProfileService.bonusService.hasDailyBonus(bonusReasonEnum: .dailyRetension)
            case .dailySpeed:
                return ProfileService.bonusService.hasDailyBonus(bonusReasonEnum: .dailySpeed)
            case .dailyDegree:
                return ProfileService.bonusService.hasDailyBonus(bonusReasonEnum: .dailyDegree)
            case .none:
                return false
        }
    }
}



//MARK:- Viewable

extension ProgressPresenter: ViewableProgressPresenter {
    

    func setView(vc: PresentableView) {
        self.vc = vc as? PresentableProgressView
    }
    
    
    func viewWillAppear() {
        calcBonus(reason: .dailyRetension)
        let hasBonus1 = hasDailyBonus(reason: .dailyRetension)
        vc?.showRetensionIconBonus(hasBonus: hasBonus1)
        
        calcBonus(reason: .dailySpeed)
        let hasBonus2 = hasDailyBonus(reason: .dailySpeed)
        vc?.showSpeedIconBonus(hasBonus: hasBonus2)
        
        calcBonus(reason: .dailyDegree)
        let hasBonus3 = hasDailyBonus(reason: .dailyDegree)
        vc?.showDegreeIconBonus(hasBonus: hasBonus3)
    }
    
    
    func radar_getCurrentRetension() -> Double {
        let retension = ProfileService.achievementService.getCurrentRetensionInPercent() + tail
        let res = 0.004 * retension  // 100% = 0.4
        return res
    }
    
    
    func radar_getCurrentSpeed() -> Double {
        let speed = ProfileService.achievementService.getCurrentSpeedInPercent() + tail
        let res = 0.004 * speed // 100% = 0.4
        return res
    }
    
    
    func radar_getCurrentDegree() -> Double {
        let degree = ProfileService.achievementService.getCurrentDegreeInPercent() + tail
        let res = 0.004 * degree  // 100% = 0.4
        return res
    }
    
    func bar_getCurrentRetension() -> Double {
        let completedDays = ProfileService.achievementService.getCurrentRetensionInDays()
        let percent = calcPercentUsedDays(completedDays: completedDays)
        return percent
    }
    
    
    func bar_getCurrentSpeed() -> Double {
        let completedDays = ProfileService.achievementService.getCurrentSpeedInDays()
        let percent = calcPercentUsedDays(completedDays: completedDays)
        return percent
    }
    
    
    func bar_getCurrentDegree() -> Double {
        let completedDays = ProfileService.achievementService.getCurrentDegreeInDays()
        let percent = calcPercentUsedDays(completedDays: completedDays)
        return percent
    }
    

    func bar_getTargetLineText(achievementGroupEnum : AchievementGroupEnum) -> String? {
        var days: Double = 0
        var nextAchievement: AchievementEnum?
        switch achievementGroupEnum {
            case .speed:
                days = ProfileService.achievementService.getCurrentSpeedInDays()
                nextAchievement = ProfileService.achievementService.getNextSpeed()
            case .retension:
                days = ProfileService.achievementService.getCurrentRetensionInDays()
                nextAchievement = ProfileService.achievementService.getNextRetension()
            case .degree:
                days = ProfileService.achievementService.getCurrentDegreeInDays()
                nextAchievement = ProfileService.achievementService.getNextDegree()
        }
        guard let next: AchievementEnum  = nextAchievement else { return nil }
        let desc = AchievementEnum.getDesc(achievementEnum: next)
        return "\(desc) : \(Int(days))/\(ACHIEVEMENT_PERIOD_IN_DAYS)"
    }
    
    
    func bar_getTargetLineY(achievementGroupEnum : AchievementGroupEnum) -> Double {
        var naturalPercent: Double = 0
        switch achievementGroupEnum {
            case .speed:
                naturalPercent = ProfileService.achievementService.getSpeedTarget()
            case .retension:
                naturalPercent = ProfileService.achievementService.getRetensionTarget()
            case .degree:
                naturalPercent = ProfileService.achievementService.getDegreeTarget()
        }
        return naturalPercent
    }
    
    
    func bar_getSpeedByDays() -> [Double]? {
        return ProfileService.achievementService.getAvgSpeedByDays()
    }
    
    
    func bar_getRetensionByDays() -> [Double]? {
        return ProfileService.achievementService.getAvgRetentionByDays()
    }
    
    
    func bar_getDegreeByDays() -> [Double]? {
        return ProfileService.achievementService.getAvgDegreeByDays()
    }
    
    func didPressBonusRetension() {
        guard let (amt, currency) = ProfileService.bonusService.showDailyBonus(bonusReasonEnum: .dailyRetension) else { return }
        let currencySymbol = CurrencyEnum.getCurrencySymbol(currencyEnum: currency)
        let bonusText: String = "Бонус: +\(currencySymbol)\(Int(amt))"
        ProfileService.setDepo(amount: amt)
        vc?.startRetensionBonusAnimation(bonusText: bonusText)
    }
    
    
    func didPressBonusSpeed() {
        guard let (amt, currency) = ProfileService.bonusService.showDailyBonus(bonusReasonEnum: .dailySpeed) else { return }
        let currencySymbol = CurrencyEnum.getCurrencySymbol(currencyEnum: currency)
        let bonusText: String = "Бонус: +\(currencySymbol)\(Int(amt))"
        ProfileService.setDepo(amount: amt)
        vc?.startSpeedBonusAnimation(bonusText: bonusText)
    }
    
    
    func didPressBonusDegree() {
        guard let (amt, currency) = ProfileService.bonusService.showDailyBonus(bonusReasonEnum: .dailyDegree) else { return }
        let currencySymbol = CurrencyEnum.getCurrencySymbol(currencyEnum: currency)
        let bonusText: String = "Бонус: +\(currencySymbol)\(Int(amt))"
        ProfileService.setDepo(amount: amt)
        vc?.startDegreeBonusAnimation(bonusText: bonusText)
    }
}
