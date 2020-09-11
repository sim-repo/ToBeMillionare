//
//  BonusService.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 20.08.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import Foundation


final class BonusService {
    
    private var playerId: Int?
    private var bonusHistories: [BonusHistoryModel] = []
    
    init(playerId: Int) {
        self.playerId = playerId
        loadBonusHistories()
    }
    
    private func loadBonusHistories() {
        guard let playerId = self.playerId else { return }
        if let histories = FilesManager.shared.loadBonusHistories(playerId: playerId) {
            self.bonusHistories = histories
        }
    }

    
    public func saveBonusHistory(bonus: BonusHistoryModel) {
        guard let playerId = self.playerId else { return }
        FilesManager.shared.saveBonusHistory(playerId: playerId, histories: bonusHistories)
    }
    
    
    // 1st - day before yesterday, 2nd - yesterday, 3rd - today
    // need always compare 1st and 2nd, but today we need to drop
    public func calcBonus(avgBySerialDays: [Double], bonusReasonEnum: BonusReasonEnum, actualCurrency: CurrencyEnum) -> Double {
        
        guard let playerId = self.playerId else { return 0 }
        guard avgBySerialDays.count >= 3 else { return 0 }
        
        let checkIdx = avgBySerialDays.count - 2
        
        //calc for new serial day only:
        if let _ = self.bonusHistories.first(where: {$0.getCheckedSerialDay() == checkIdx && $0.getReason() == bonusReasonEnum}) {
            return 0
        }
        
        let avg1: Double = avgBySerialDays[checkIdx]
        let avg2: Double = avgBySerialDays[checkIdx-1]
        
        let diff = ((avg1 - avg2) / avg2) * 100
        let amount = BonusReasonEnum.getBonusAmount(dailyDiffPercent: diff )
        guard amount > 0 else { return 0 }
        
        let bonus: BonusHistoryModel = BonusHistoryModel(id: 0, playerId: playerId)
        bonus.setReason(reasonEnum: bonusReasonEnum)
        bonus.setBonusAmount(amount)
        bonus.setCheckedSerialDay(serialDay: checkIdx)
        bonus.setBonusCurrency(currencyEnum: actualCurrency)
        bonusHistories.append(bonus)
        saveBonusHistory(bonus: bonus)
        return 0
    }
    
    
    public func hasDailyBonus(bonusReasonEnum: BonusReasonEnum) -> Bool {
        if let _ = self.bonusHistories.first(where: {$0.getReason() == bonusReasonEnum && $0.getShownToPlayer() == false}) {
            return true
        }
        return false
    }
    
    
    public func getBonusCurrency(bonusReasonEnum: BonusReasonEnum) -> CurrencyEnum {
        if let bonus = self.bonusHistories.first(where: {$0.getReason() == bonusReasonEnum && $0.getShownToPlayer() == false}) {
            return bonus.getBonusCurrency()
        }
        return .none
    }
    
    
    public func showDailyBonus(bonusReasonEnum: BonusReasonEnum) -> (Double,CurrencyEnum)? {
        if let bonus = self.bonusHistories.first(where: {$0.getReason() == bonusReasonEnum && $0.getShownToPlayer() == false}) {
            bonus.setShownToPlayer()
            saveBonusHistory(bonus: bonus)
            return (bonus.getBonusAmount(), bonus.getBonusCurrency())
        }
        return nil
    }
}
