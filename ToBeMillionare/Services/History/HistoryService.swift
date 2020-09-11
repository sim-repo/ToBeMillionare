//
//  HistoryService.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 19.06.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import Foundation


final class HistoryService {
    
    private var curHistory: HistoryModel?
    private static var histories: [HistoryModel] = []
    
    public static func getHistories(gameModeEnum: GameModeEnum, playerId: Int) -> [ReadableHistory]? {
        if histories.isEmpty == false {
            return histories
        }
        guard let histories = FilesManager.shared.loadHistories(gameModeEnum: gameModeEnum, playerId: playerId)
            else { return nil }
        
        if validHistories() == false {
            emergencyCatchHistory(gameModeEnum: gameModeEnum, playerId: playerId)
            return nil
        }
        self.histories = histories
        return self.histories
    }
    
    
    private static func validHistories() -> Bool {
        for history in histories {
            guard history.getAccumulatedResponseTime() >= 0 else
            { return false }
            guard history.getBetPercentOfDepo() >= 0 else
            { return false }
        }
        return true
    }
    
    
    // 1st day - [ReadableHistory], 2nd day - [ReadableHistory], ...
    public static func getHistoriesBySerialDay() -> [Int: [ReadableHistory]]? {
        
        guard histories.isEmpty == false else {
            return nil
        }
        
        var result: [Int: [ReadableHistory]] = [:]
        
        let groupDic = Dictionary(grouping: histories) { (histories) -> DateComponents in
            let date = Calendar.current.dateComponents([.day, .year, .month], from: (histories.getDate()))
            return date
        }
        
        let sortedList = groupDic.sorted {
            Calendar.current.date(from: $0.key) ?? Date.distantFuture <
                Calendar.current.date(from: $1.key) ?? Date.distantFuture
        }
        
        for (idx,element) in sortedList.enumerated() {
            result[idx] = element.value
        }
        return result
    }
    
    
    public static func emergencyCatchHistory(gameModeEnum: GameModeEnum, playerId: Int) {
        FilesManager.shared.emergencyRemoveHistory(gameModeEnum: gameModeEnum, playerId: playerId)
    }
    
    
    public func getPassedQuestionIds(gameModeEnum: GameModeEnum, playerId: Int, orderBy: OrderByEnum) -> [Int]? {
        if let histories = HistoryService.getHistories(gameModeEnum: gameModeEnum, playerId: playerId),
            histories.count > 0 {
            
            if orderBy == .asc {
                return histories
                    .sorted(by: {$0.getDate() < $1.getDate()})
                    .compactMap{$0.getPassedQuestionIds()}
                    .flatMap{$0}
            }
            
            if orderBy == .desc {
                return histories
                    .sorted(by: {$0.getDate() > $1.getDate()})
                    .compactMap{$0.getPassedQuestionIds()}
                    .flatMap{$0}
            }
        }
        return nil
    }
    
}


// MARK:- Set
extension HistoryService {
    
    public func createHistory(gameModeEnum: GameModeEnum, playerId: Int, _ date: Date = Date()) {
        var id = 0
        if let histories = HistoryService.getHistories(gameModeEnum: gameModeEnum, playerId: playerId) {
            if let lasHistory = histories.sorted(by: {$0.getId() < $1.getId()}).last {
                id = lasHistory.getId() + 1
            }
        }
        curHistory = HistoryModel(id: id, playerId: playerId, date: date)
    }
    
    public func saveHistory(gameModeEnum: GameModeEnum, playerId: Int) {
        guard let curHistory = curHistory else { return }
        HistoryService.histories.append(curHistory)
        FilesManager.shared.saveHistory(gameModeEnum: gameModeEnum, playerId: playerId, histories: HistoryService.histories)
    }
    
    
    public func setPassedQuestion(questionId: Int) {
        curHistory?.setPassedQuestion(questionId: questionId)
    }
    
    public func setRound(roundEnum: RoundEnum) {
        curHistory?.setRound(roundEnum: roundEnum)
    }
    
    public func setAccumulatedResponseTime(time: Int) {
        curHistory?.setAccumulatedResponseTime(accumulatedResponseTime: time)
    }
    
    public func setBetPercentOfDepo(percent: Double) {
        curHistory?.setBetPercentOfDepo(percent: percent)
    }
    
    public func setBetResult(sum: Double) {
        curHistory?.setBetResult(sum: sum)
    }
}
