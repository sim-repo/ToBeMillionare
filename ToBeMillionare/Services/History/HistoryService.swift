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
    private var histories: [HistoryModel] = []
    
    public func getHistories(gameModeEnum: GameModeEnum, playerId: Int) -> [HistoryModel]? {
        guard let histories = FilesManager.shared.loadHistories(gameModeEnum: gameModeEnum, playerId: playerId)
            else { return nil }
        
        self.histories = histories
        if histories.count > 30 { // nullify
            return nil
        }
        let filtered = histories.filter{$0.getPlayerId() == playerId}
        return filtered
    }
    
    
    public func saveHistory(gameModeEnum: GameModeEnum, playerId: Int) {
        guard let curHistory = curHistory else { return }
        histories.append(curHistory)
        FilesManager.shared.saveHistory(gameModeEnum: gameModeEnum, playerId: playerId, histories: histories)
    }
    
    
    public func getPassedQuestionIds(gameModeEnum: GameModeEnum, playerId: Int, orderBy: OrderByEnum) -> [Int]? {
        if let histories = getHistories(gameModeEnum: gameModeEnum, playerId: playerId),
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
    
    
    public func createHistory(gameModeEnum: GameModeEnum, playerId: Int) {
        var id = 0
        if let histories = getHistories(gameModeEnum: gameModeEnum, playerId: playerId) {
            if let lasHistory = histories.sorted(by: {$0.getId() < $1.getId()}).last {
                id = lasHistory.getId() + 1
            }
        }
        curHistory = HistoryModel(id: id, playerId: playerId)
    }
    
    
    func setDate(date: Date) {
        curHistory?.setDate(date: date)
    }
    
    func setPassedQuestion(questionId: Int) {
        curHistory?.setPassedQuestion(questionId: questionId)
    }
    
    func setLevel(levelEnum: LevelEnum) {
        curHistory?.setLevel(levelEnum: levelEnum)
    }
    
    public func setUsedFriendHint(enabled: Bool) {
        curHistory?.setUsedFriendHint(enabled: enabled)
    }
    
    public func setUsedAuditoryHint(enabled: Bool) {
        curHistory?.setUsedAuditoryHint(enabled: enabled)
    }
    
    public func setUsedFiftyHint(enabled: Bool) {
        curHistory?.setUsedFiftyHint(enabled: enabled)
    }
}
