//
//  AchievementService.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 24.06.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import Foundation


final class AchievementService {
    
    internal var profilePresenter: ReadableProfilePresenter {
        let presenter: ProfilePresenter = PresenterFactory.shared.getInstance()
        return presenter as ReadableProfilePresenter
    }
    
    private var histories: [ReadableHistory]?
    
    init(histories: [ReadableHistory]?) {
        self.histories = histories
    }
    
    // used in profile view
    public func getAchievements() -> [AchievementEnum] {
        return profilePresenter.getSelected().getAchievementEnums()
    }
}


//MARK:- in play session
extension AchievementService {
    
    public func calcRetension() -> AchievementEnum? {
        guard let next = getNextRetension() else { return nil }
        
        let percent = getCurrentRetensionInPercent()
        switch percent {
            case 25.0:
                if next == .retension1 {
                    return .retension1
                }
            case 50:
                if next == .retension2 {
                    return .retension2
                }
            case 75:
                if next == .retension3 {
                    return .retension3
                }
            case 100:
                if next == .retension4 {
                    return .retension4
                }
            default:
                break
        }
        return nil
    }
    
    
    
    
    public func calcDegree() -> AchievementEnum? {
        guard let next = getNextDegree() else { return nil }
        let percent = getCurrentDegreeInPercent()
        switch percent {
            case 25.0:
                if next == .degree1 {
                    return .degree1
                }
            case 50:
                if next == .degree2 {
                    return .degree2
                }
            case 75:
                if next == .degree3 {
                    return .degree3
                }
            case 100:
                if next == .degree4 {
                    return .degree4
                }
            default:
                break
        }
        return nil
    }
    
    
    
    public func calcSpeed() -> AchievementEnum? {
        guard let next = getNextSpeed() else { return nil }
        let percent = getCurrentSpeedInPercent()
        switch percent {
            case 25.0:
                if next == .speed1 {
                    return .speed1
                }
            case 50:
                if next == .speed2 {
                    return .speed2
                }
            case 75:
                if next == .speed3 {
                    return .speed3
                }
            case 100:
                if next == .speed4 {
                    return .speed4
                }
            default:
                break
        }
        return nil
    }
    
    
    public func getHighRetension() -> AchievementEnum? {
        return hasAchievement(achievementEnum4: .retension4, achievementEnum3: .retension3, achievementEnum2: .retension2, achievementEnum1: .retension1)
    }
    
    
    public func getHighSpeed() -> AchievementEnum? {
        return hasAchievement(achievementEnum4: .speed4, achievementEnum3: .speed3, achievementEnum2: .speed2, achievementEnum1: .speed1)
    }
    
    
    public func getHighDegree() -> AchievementEnum? {
        return hasAchievement(achievementEnum4: .degree4, achievementEnum3: .degree3, achievementEnum2: .degree2, achievementEnum1: .degree1)
    }
    
    
    internal func hasAchievement(_ achievementEnum: AchievementEnum) -> Bool {
        return getAchievements().contains(where: {$0 == achievementEnum})
    }
    
    private func hasAchievement(achievementEnum4: AchievementEnum,
                                achievementEnum3: AchievementEnum,
                                achievementEnum2: AchievementEnum,
                                achievementEnum1: AchievementEnum) -> AchievementEnum? {
        guard getAchievements().isEmpty == false else { return nil }
        if getAchievements().contains(where: {$0 == achievementEnum4}) {
            return achievementEnum4
        }
        if getAchievements().contains(where: {$0 == achievementEnum3}) {
            return achievementEnum3
        }
        if getAchievements().contains(where: {$0 == achievementEnum2}) {
            return achievementEnum2
        }
        if getAchievements().contains(where: {$0 == achievementEnum1}) {
            return achievementEnum1
        }
        return nil
    }
    
    
    public func getSpeedTarget() -> Double {
        if hasAchievement(.speed1) == false {
            return getTarget(.speed1)
        }
        
        if hasAchievement(.speed2) == false {
            return getTarget(.speed2)
        }
        
        if hasAchievement(.speed3) == false {
            return getTarget(.speed3)
        }
        
        if hasAchievement(.speed4) == false {
            return getTarget(.speed4)
        }
        return 0
    }
    
    
    public func getRetensionTarget() -> Double {
        if hasAchievement(.retension1) == false {
            return getTarget(.retension1)
        }
        
        if hasAchievement(.retension2) == false {
            return getTarget(.retension2)
        }
        
        if hasAchievement(.retension3) == false {
            return getTarget(.retension3)
        }
        
        if hasAchievement(.retension4) == false {
            return getTarget(.retension4)
        }
        return 0
    }
    
    
    public func getDegreeTarget() -> Double {
        if hasAchievement(.degree1) == false {
            return getTarget(.degree1)
        }
        
        if hasAchievement(.degree2) == false {
            return getTarget(.degree2)
        }
        
        if hasAchievement(.degree3) == false {
            return getTarget(.degree3)
        }
        
        if hasAchievement(.degree4) == false {
            return getTarget(.degree4)
        }
        return 0
    }
}

