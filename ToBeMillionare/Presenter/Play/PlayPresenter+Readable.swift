//
//  PlayPresenter+Readable.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 19.06.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import Foundation



//MARK:- Readable

extension PlayPresenter: ReadablePlayPresenter {
    
    func getActualCurrency() -> CurrencyEnum {
        return sessionService.getActualCurrency()
    }
    
    func gotoMainMenu(deepness: Int) {
        vc?.gotoMainMenu(deepness: deepness)
    }
    
    func getRound() -> RoundEnum {
        return sessionService.getRound()
    }
    
    func getQuestion() -> String {
        return curQuestion.getQuestionText()
    }
    
    func getAward() -> Double {
        return sessionService.getAward()
    }
    
    func getFriendAnswer(occupationEnum: OccupationEnum) -> ReadableAnswer {
        return sessionService.getFriendAnswer(occupationEnum: occupationEnum)
    }
    
    func getDepo() -> Double {
        return sessionService.profile.getDepo()
    }
    
    func getMinAward() -> Double {
        tmpAward = sessionService.getMinAward()
        return tmpAward
    }
    
    func getMinBetSum() -> Double {
        return sessionService.getBetMinSum()
    }
    
    func getFireproofRound(_ cachedDepo: Double? = nil) -> Int {
        return sessionService.getFireproofRound(cachedDepo: cachedDepo).rawValue
    }
    
    func canSelectBet() -> Bool {
        return sessionService.canSelectBet()
    }
    
    func getBetSum() -> Double {
        return sessionService.getBetSum()
    }
    
    func getStageAim() -> Double {
        return sessionService.getStageAim()
    }
    
    func getGamesCount() -> Int {
        return sessionService.getGamesCount()
    }
    
    func getStage() -> Int {
        return sessionService.getStage()
    }
    
    func getDaysLeftBeforeDisaster() -> Int {
        return sessionService.getDaysBeforeDisaster()
    }
    
    func getZondRecovery() -> Int {
        let zondRecovery = Int(Double(getStage()) * 14.29)
        return zondRecovery
    }
}
