//
//  AchievementService+AvgByDays.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 14.08.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import Foundation



//MARK:- fill by days
extension AchievementService {
    
    public func getAvgSpeedByDays() -> [Double]? {
        guard let historiesByDays = HistoryService.getHistoriesBySerialDay(),
            historiesByDays.count > 0
            else { return nil }
        
        var avgSpeedArr: [Double] = [] // id:avg
        
        let sorted = historiesByDays.sorted(by: {$0.key < $1.key})
        
        for dict in sorted {
            
            let histories = dict.value
            
            let sumResponseTime = histories
                .map{$0.getAccumulatedResponseTime()}
                .reduce(0, { x, y in x + y })
            
            let questionsCount = histories
                .map{$0.getPassedQuestionIds().count}
                .reduce(0, { x, y in x + y })
            
            if questionsCount > 0 {
                //calc remaining of countdown in percent: 54 sec/60 sec = 90%, 53 sec/60 sec = 88%; 90% faster than 88%
                let percent: Double = (ROUND_TIME - Double(sumResponseTime / questionsCount)) / ROUND_TIME * 100
                avgSpeedArr.append(percent)
            }
        }
        return avgSpeedArr
    }
    
    
    public func getAvgRetentionByDays() -> [Double]? {
        guard let historiesByDays = HistoryService.getHistoriesBySerialDay(),
            historiesByDays.count > 0
            else { return nil }
        return historiesByDays.sorted(by: {$0.key < $1.key}).map{$0.value.count > Int(ACHIEVEMENT_MAX_DAILY_RETENSION) ? 100 : Double($0.value.count) / ACHIEVEMENT_MAX_DAILY_RETENSION*100}
    }
    
    
    public func getAvgDegreeByDays() -> [Double]? {
        
        guard let historiesByDays = HistoryService.getHistoriesBySerialDay(),
            historiesByDays.count > 0
            else { return nil }
        
        let sorted = historiesByDays.sorted(by: {$0.key < $1.key})
        
        var avgDegreeArr: [Double] = [] // id:avg
        
        for dict in sorted {
            
            let histories = dict.value
            let sumRounds = histories
                .map{$0.getRound().rawValue}
                .reduce(0, { x, y in x + y })
            
            let gamesCount = histories.count
            
            if gamesCount > 0 {
                let percent: Double = ((Double(sumRounds / gamesCount)) / MAX_GAME_QUESTIONS) * 100
                avgDegreeArr.append(percent)
            }
        }
        return avgDegreeArr
    }
}
