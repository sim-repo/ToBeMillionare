//
//  AchievementService+RadarChart.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 14.08.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import Foundation


//MARK:- calc achievements: speed, retension, degree

extension AchievementService {
    
    //MARK:- Speed
    
    public func getNextSpeed() -> AchievementEnum? {
        if hasAchievement(.speed4) == true {
            return nil
        }
        if hasAchievement(.speed3) == true {
            return .speed4
        }
        if hasAchievement(.speed2) == true {
            return .speed3
        }
        if hasAchievement(.speed1) == true {
            return .speed2
        }
        return .speed1
    }
    
    
    private func getCurrentSpeed(inPercent: Bool) -> Double {
        if let speed = getHighSpeed(),
            speed == .speed4 {
            return 100
        }
        
        guard let speedByDays = getAvgSpeedByDays()
            else { return 0 }
        
        let target1 = getTarget(.speed1)
        let target2 = getTarget(.speed2)
        let target3 = getTarget(.speed3)
        let target4 = getTarget(.speed4)
        
        let currentVal = calcCurrentProgress(inPercent: inPercent, achievements: [.speed1, .speed2, .speed3, .speed4], metricsByDays: speedByDays, targets: [target1,target2,target3,target4])
        return currentVal
    }
    
    
    public func getCurrentSpeedInPercent() -> Double {
        return getCurrentSpeed(inPercent: true)
    }
    
    public func getCurrentSpeedInDays() -> Double {
        return getCurrentSpeed(inPercent: false)
    }
    
    
    
    //MARK:- Retension
    
    public func getNextRetension() -> AchievementEnum? {
        if hasAchievement(.retension4) == true {
            return nil
        }
        if hasAchievement(.retension3) == true {
            return .retension4
        }
        if hasAchievement(.retension2) == true {
            return .retension3
        }
        if hasAchievement(.retension1) == true {
            return .retension2
        }
        return .retension1
    }
    
    
    private func getCurrentRetension(inPercent: Bool) -> Double {
        if let retension = getHighRetension(),
            retension == .retension4 {
            return 100
        }
        
        guard let retentionByDays = getAvgRetentionByDays()
            else { return 0 }
        
        
        let target1 = getTarget(.retension1)
        let target2 = getTarget(.retension2)
        let target3 = getTarget(.retension3)
        let target4 = getTarget(.retension4)
        
        let currentVal = calcCurrentProgress(inPercent: inPercent, achievements: [.retension1, .retension2, .retension3, .retension4], metricsByDays: retentionByDays, targets: [target1,target2,target3,target4])
        return currentVal
    }
    
    
    public func getCurrentRetensionInPercent() -> Double {
        return getCurrentRetension(inPercent: true)
    }
    
    public func getCurrentRetensionInDays() -> Double {
        return getCurrentRetension(inPercent: false)
    }
    
    
    //MARK:- Degree
    
    public func getNextDegree() -> AchievementEnum? {
        if hasAchievement(.degree4) == true {
            return nil
        }
        if hasAchievement(.degree3) == true {
            return .degree4
        }
        if hasAchievement(.degree2) == true {
            return .degree3
        }
        if hasAchievement(.degree1) == true {
            return .degree2
        }
        return .degree1
    }
    
    
    public func getCurrentDegree(inPercent: Bool) -> Double {
        if let degree = getHighDegree(),
            degree == .degree4 {
            return 100
        }
        
        guard let degreeByDays = getAvgDegreeByDays()
            else { return 0 }
        
        let target1 = getTarget(.degree1)
        let target2 = getTarget(.degree2)
        let target3 = getTarget(.degree3)
        let target4 = getTarget(.degree4)
        
        let currentVal = calcCurrentProgress(inPercent: inPercent, achievements: [.degree1, .degree2, .degree3, .degree4], metricsByDays: degreeByDays, targets: [target1,target2,target3,target4])
        return currentVal
    }
    
    
    public func getCurrentDegreeInPercent() -> Double {
        return getCurrentDegree(inPercent: true)
    }
    
    public func getCurrentDegreeInDays() -> Double {
        return getCurrentDegree(inPercent: false)
    }
    
    
    
    internal func getTarget(_ achievementEnum: AchievementEnum) -> Double {
        let gameMode = profilePresenter.getSelected().getGameMode()
        return AchievementEnum.getTarget(achievementEnum: achievementEnum, gameModeEnum: gameMode)
    }
    
    
    private func calcCurrentProgress(inPercent: Bool, achievements: [AchievementEnum], metricsByDays: [Double], targets: [Double]) -> Double {
        
        var days1to7: [Double] = []
        var days8to14: [Double] = []
        var days15to22: [Double] = []
        var days23to30: [Double] = []
        
        for (idx,metric) in metricsByDays.enumerated() {
            switch idx {
            case 0...ACHIEVEMENT_PERIOD_IN_DAYS-1:
                if targets[0]... ~= metric {
                    days1to7.append(metric)
                }
            case ACHIEVEMENT_PERIOD_IN_DAYS...2*ACHIEVEMENT_PERIOD_IN_DAYS-1:
                if targets[1]... ~= metric {
                    days8to14.append(metric)
                }
            case 2*ACHIEVEMENT_PERIOD_IN_DAYS...3*ACHIEVEMENT_PERIOD_IN_DAYS-1:
                if targets[2]... ~= metric {
                    days15to22.append(metric)
                }
            case 3*ACHIEVEMENT_PERIOD_IN_DAYS...4*ACHIEVEMENT_PERIOD_IN_DAYS-1:
                if targets[3]... ~= metric {
                    days23to30.append(metric)
                }
            default:
                break
            }
        }
        
        // calc <= 25%
        if hasAchievement(achievements[0]) == false {
            if days1to7.count >= ACHIEVEMENT_PERIOD_IN_DAYS {
                return inPercent ? 25 : Double(ACHIEVEMENT_PERIOD_IN_DAYS) // 25% or 7 days completed
            }
            return inPercent ? Double(25*days1to7.count) * 1/Double(ACHIEVEMENT_PERIOD_IN_DAYS) : Double(days1to7.count)
        }
        
        // calc <= 50%
        if hasAchievement(achievements[1]) == false {
            if days8to14.count >= ACHIEVEMENT_PERIOD_IN_DAYS {
                return inPercent ? 50 : Double(ACHIEVEMENT_PERIOD_IN_DAYS) // 50% or 7 days completed
            }
            return inPercent ? 25 + Double(25*days8to14.count) * 1/Double(ACHIEVEMENT_PERIOD_IN_DAYS) : Double(days8to14.count)
        }
        
        // calc <= 75%
        if hasAchievement(achievements[2]) == false {
            if days15to22.count >= ACHIEVEMENT_PERIOD_IN_DAYS {
                return inPercent ? 75 : Double(ACHIEVEMENT_PERIOD_IN_DAYS) // 75% or 7 days completed
            }
            return inPercent ? 50 + Double(25*days15to22.count) * 1/Double(ACHIEVEMENT_PERIOD_IN_DAYS) : Double(days15to22.count)
        }
        
        
        // calc <= 100%
        if hasAchievement(achievements[3]) == false {
            if days23to30.count >= ACHIEVEMENT_PERIOD_IN_DAYS {
                return inPercent ? 100 : Double(ACHIEVEMENT_PERIOD_IN_DAYS) // 100% or 7 days completed
            }
            return inPercent ? 75 + Double(25*days23to30.count) * 1/Double(ACHIEVEMENT_PERIOD_IN_DAYS) : Double(days23to30.count)
        }
        return 0
    }
    
}
