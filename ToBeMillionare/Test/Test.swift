//
//  Test.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 23.08.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import Foundation






class Test {
    
    private var historyService: HistoryService!
    private var gameMode: GameModeEnum = .easy
    private var playerId: Int = 0
    
    internal var profile: ReadableProfile {
        return ProfileService.getForcedSelected()
    }
    
    struct TestData {
        var playerId: Int
        var offsetDay: Int
        var gameMode: GameModeEnum
        var playedDays: Int
        var achievements: [AchievementEnum]
        var targetBonusAmount: Double
    }
    
    internal func setProfile(testData: TestData) {
        for achievement in testData.achievements {
            ProfileService.setAchievement(achievementEnum: achievement)
        }
    }
    
    
    internal func createHistoryService(testData: TestData) {
        self.playerId = testData.playerId
        self.gameMode = testData.gameMode
        historyService = HistoryService()
        historyService.createHistory(gameModeEnum: gameMode, playerId: playerId)
    }
    
    
    internal func createGameSession(date: Date, maxRound: RoundEnum, fullTimeForResponse: Int) {
        historyService.createHistory(gameModeEnum: gameMode, playerId: playerId, date)
        historyService.setRound(roundEnum: maxRound)
        for _ in 0...maxRound.rawValue - 1 {
            historyService.setPassedQuestion(questionId: 1)
        }
        historyService.setAccumulatedResponseTime(time: fullTimeForResponse)
        historyService.saveHistory(gameModeEnum: gameMode, playerId: playerId)
    }
    
    
    internal func createGameSession(date: Date, maxRound: RoundEnum, maxQuestions: Int, fullTimeForResponse: Int) {
        historyService.createHistory(gameModeEnum: gameMode, playerId: playerId, date)
        historyService.setRound(roundEnum: maxRound)
        for _ in 0...maxQuestions - 1 {
            historyService.setPassedQuestion(questionId: 1)
        }
        historyService.setAccumulatedResponseTime(time: fullTimeForResponse)
        historyService.saveHistory(gameModeEnum: gameMode, playerId: playerId)
    }
}



