//
//  BonusHistoryModel.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 20.08.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import Foundation

final class BonusHistoryModel: Codable {
    
    private var id: Int = 0
    private var playerId: Int = 0
    private var checkedSerialDay: Int = 0
    private var checkDate: Date = Date()
    private var reasonEnum: BonusReasonEnum = .none
    private var bonusAmount: Double = 0
    private var bonusCurrency: CurrencyEnum = .none
    private var shownToPlayer: Bool = false
    
    internal init(id: Int, playerId: Int) {
        self.id = id
        self.playerId = playerId
        self.checkDate = Date()
    }
    
    //MARK:- Codable >>
    enum CodingKeys: String, CodingKey {
        case id
        case playerId
        case checkedSerialDay
        case checkDate
        case reasonEnum
        case bonusAmount
        case bonusCurrency
        case shownToPlayer
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(playerId, forKey: .playerId)
        try container.encode(checkedSerialDay, forKey: .checkedSerialDay)
        try container.encode(checkDate, forKey: .checkDate)
        try container.encode(reasonEnum.rawValue, forKey: .reasonEnum)
        try container.encode(bonusAmount, forKey: .bonusAmount)
        try container.encode(bonusCurrency.rawValue, forKey: .bonusCurrency)
        try container.encode(shownToPlayer, forKey: .shownToPlayer)
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        playerId = try container.decode(Int.self, forKey: .playerId)
        checkedSerialDay = try container.decode(Int.self, forKey: .checkedSerialDay)
        checkDate = try container.decode(Date.self, forKey: .checkDate)
        let stringReason = try container.decode(String.self, forKey: .reasonEnum)
        self.reasonEnum = BonusReasonEnum.init(rawValue: stringReason)!
        bonusAmount = try container.decode(Double.self, forKey: .bonusAmount)
        shownToPlayer = try container.decode(Bool.self, forKey: .shownToPlayer)
        let stringCurrency = try container.decode(String.self, forKey: .bonusCurrency)
        self.bonusCurrency = CurrencyEnum.init(rawValue: stringCurrency)!
    }
}


//MARK:- setters

extension BonusHistoryModel {
    
    func setReason(reasonEnum: BonusReasonEnum) {
        self.reasonEnum = reasonEnum
    }
    
    func setBonusAmount(_ amount: Double) {
        self.bonusAmount = amount
    }
    
    func setBonusCurrency(currencyEnum: CurrencyEnum) {
        self.bonusCurrency = currencyEnum
    }
    
    func setCheckedSerialDay(serialDay: Int) {
        checkedSerialDay = serialDay
    }
    
    func setShownToPlayer() {
        shownToPlayer = true
    }
}


//MARK:- getters

extension BonusHistoryModel: ReadableBonusHistory {
    
    func getId() -> Int {
        return id
    }
    
    func getPlayerId() -> Int {
        return playerId
    }
    
    func getCheckedSerialDay() -> Int {
        return checkedSerialDay
    }
    
    func getCheckDate() -> Date {
        return checkDate
    }
    
    func getReason() -> BonusReasonEnum {
        return reasonEnum
    }
    
    func getBonusAmount() -> Double {
        return bonusAmount
    }
    
    func getShownToPlayer() -> Bool {
        return shownToPlayer
    }
    
    func getBonusCurrency() -> CurrencyEnum {
        return bonusCurrency
    }
}
