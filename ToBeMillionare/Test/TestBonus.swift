//
//  TestBonus.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 23.08.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import Foundation



class TestBonus : Test {
    
    
    override init() {
        super.init()
        let testData = TestData(playerId: profile.getId(), offsetDay: 10, gameMode: profile.getGameMode(), playedDays: 7, achievements: [], targetBonusAmount: 40)
        //genBonusSpeed(testData: testData)
        //genBonusRetension(testData: testData)
        //genBonusDegree(testData: testData)
        genFullBonuses(testData: testData)
    }
    
    
    private func checkAndSetup(_ testData: TestData) -> Bool {
        guard testData.playedDays >= 3 else { return false}
        setProfile(testData: testData)
        createHistoryService(testData: testData)
        return true
    }
    
    
    func genBonusSpeed(testData: TestData) {
        guard checkAndSetup(testData) else { return }
        
        // x: time rem in sec for prev question
        // y: time rem in sec for cur question
        //    (y - x) / x == 0.2 // calc diff in percent ==  20%
        // 1)   60 - x = 30 // time remaining in sec
        // 2)   60 - y = z // z = spent time before answer in sec
        
        let maxRound: RoundEnum = .round10 // const!
        for day in 1...testData.playedDays {
            let date = Date.daysAdd(days: -1*testData.playedDays + day - testData.offsetDay)
            
            var reponseTime: Double = 0
            let x: Double = 60 - 30 // 1) x = 60 - 30 = 30
            if day == testData.playedDays - 2 {
                reponseTime = x * Double(maxRound.rawValue) // 50 remain
            }
            if day == testData.playedDays - 1 {
                reponseTime = getYesterdayResponseTime(testData.targetBonusAmount, x: x) * Double(maxRound.rawValue)
            }
            createGameSession(date: date, maxRound: maxRound, fullTimeForResponse: Int(reponseTime))
        }
    }
    
    
    private func getYesterdayResponseTime(_ targetBonusAmount: Double, x: Double) -> Double {
        switch targetBonusAmount {
            case 20:
                return ROUND_TIME - (0.2 * x + x) // z = 60 - y
            case 40:
                return ROUND_TIME - (0.4 * x + x)
            case 60:
                return ROUND_TIME - (0.6 * x + x)
            case 80:
                return ROUND_TIME - (0.8 * x + x)
            case 100:
                return ROUND_TIME - (x + x)
            default:
                return 0
        }
    }
    
    
    
    func genBonusRetension(testData: TestData) {
        guard checkAndSetup(testData) else { return }
        
        for day in 1...testData.playedDays {
            let date = Date.daysAdd(days: -1*testData.playedDays + day  - testData.offsetDay)
            let x: Int = 5 // 1) x = 60 - 30 = 30
            if day == testData.playedDays - 2 {
                for _ in 1...x {
                    createGameSession(date: date, maxRound: .round10, fullTimeForResponse: 1)
                }
            }
            
            if day == testData.playedDays - 1 {
                let gamesInDay = getYesterdayRetension(testData.targetBonusAmount, x: Double(x))
                for _ in 1...gamesInDay {
                    createGameSession(date: date, maxRound: .round10, fullTimeForResponse: 1)
                }
            }
            
            if day == testData.playedDays {
                createGameSession(date: date, maxRound: .round10, fullTimeForResponse: 1)
            }
        }
    }
    
    
    private func getYesterdayRetension(_ targetBonusAmount: Double, x: Double) -> Int {
        switch targetBonusAmount {
            case 20:
                return Int(0.2 * x + x)
            case 40:
                return Int(0.4 * x + x)
            case 60:
                return Int(0.6 * x + x)
            case 80:
                return Int(0.8 * x + x)
            case 100:
                return Int(x + x)
            default:
                return 0
        }
    }
    
    
    
    func genBonusDegree(testData: TestData) {
        guard checkAndSetup(testData) else { return }
        
        for day in 1...testData.playedDays {
            let date = Date.daysAdd(days: -1*testData.playedDays + day - testData.offsetDay)
            
            
            var degree: RoundEnum = .round6
            if day == testData.playedDays - 2 {
                createGameSession(date: date, maxRound: .round6, fullTimeForResponse: 1)
            }
            
            if day == testData.playedDays - 1 {
                degree = getYesterdayDegree(testData.targetBonusAmount)
                createGameSession(date: date, maxRound: degree, fullTimeForResponse: 1)
            }
            
            if day == testData.playedDays {
                createGameSession(date: date, maxRound: degree, fullTimeForResponse: 1)
            }
        }
    }
    
    
    private func getYesterdayDegree(_ targetBonusAmount: Double) -> RoundEnum {
        switch targetBonusAmount {
            case 20:
                return .round7 // 10 + 20%
            case 40:
                return .round8 // 10 + 40%
            case 60:
                return .round10 // 10 + 60%
            case 80:
                return .round11
            case 100:
                return .round12
            default:
                return .round1
        }
    }
    
    
    
    func genFullBonuses(testData: TestData) {
        guard checkAndSetup(testData) else { return }
        
        for day in 1...testData.playedDays {
            let date = Date.daysAdd(days: -1*testData.playedDays + day - testData.offsetDay)
            
            let maxRound: RoundEnum = .round10 // const!
           
            if day == testData.playedDays - 2 {
                for _ in 1...5 {
                    createGameSession(date: date, maxRound: .round6, maxQuestions: 10, fullTimeForResponse: Int(30 * Double(maxRound.rawValue)))
                }
            }
            
            if day == testData.playedDays - 1 {
                let gamesInDay = getYesterdayRetension(testData.targetBonusAmount, x: 5.0)
                let degree = getYesterdayDegree(testData.targetBonusAmount)
                for _ in 1...gamesInDay {
                    let reponseTime = getYesterdayResponseTime(testData.targetBonusAmount, x: 30.0) * Double(maxRound.rawValue)
                    createGameSession(date: date, maxRound: degree, maxQuestions: 10, fullTimeForResponse: Int(reponseTime))
                }
            }
            
            if day == testData.playedDays {
                createGameSession(date: date, maxRound: .round10, maxQuestions: 10, fullTimeForResponse: 1)
            }
        }
    }
}
