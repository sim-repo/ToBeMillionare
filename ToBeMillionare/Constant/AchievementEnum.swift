import Foundation


enum AchievementEnum: String, CaseIterable {
    
    case speed1 = "speed1"
    case speed2 = "speed2"
    case speed3 = "speed3"
    case speed4 = "speed4"
    
    
    // retenions:
    case retension1 = "retension1"
    case retension2 = "retension2"
    case retension3 = "retension3"
    case retension4 = "retension4"
    
    
    // degree:
    case degree1 = "degree1"
    case degree2 = "degree2"
    case degree3 = "degree3"
    case degree4 = "degree4"
    
    
    static func getDesc(achievementEnum: AchievementEnum) -> String {
        switch achievementEnum {
            case speed1: return "резвость"
            case speed2: return "стремительность"
            case speed3: return "реактивность"
            case speed4: return "король"
            case retension1: return "шаг за шагом"
            case retension2: return "мотивированность"
            case retension3: return "постоянство"
            case retension4: return "закаленность"
            case degree1: return "дока"
            case degree2: return "знаток"
            case degree3: return "эрудит"
            case degree4: return "мастер"
        }
    }
    
    
    static func getTarget(achievementEnum: AchievementEnum, gameModeEnum: GameModeEnum) -> Double {
        
         switch achievementEnum {
            
               case .speed1:
                    switch gameModeEnum {
                        case .easy:
                            return 50
                        case .medium:
                            return 50
                        case .difficult:
                            return 50
                    }
               case .speed2:
                   switch gameModeEnum {
                       case .easy:
                           return 60
                       case .medium:
                           return 60
                       case .difficult:
                           return 60
                   }
               case .speed3:
                   switch gameModeEnum {
                       case .easy:
                           return 70
                       case .medium:
                           return 70
                       case .difficult:
                           return 70
                   }
               case .speed4:
                   switch gameModeEnum {
                       case .easy:
                           return 80
                       case .medium:
                           return 80
                       case .difficult:
                           return 80
                   }
                   
                   
               case .retension1:
                   switch gameModeEnum {
                       case .easy:
                           return 20
                       case .medium:
                           return 20
                       case .difficult:
                           return 20
                   }
               case .retension2:
                   switch gameModeEnum {
                       case .easy:
                           return 30
                       case .medium:
                           return 30
                       case .difficult:
                           return 30
                   }
               case .retension3:
                   switch gameModeEnum {
                       case .easy:
                           return 40
                       case .medium:
                           return 40
                       case .difficult:
                           return 40
                   }
            
               case .retension4:
                   switch gameModeEnum {
                       case .easy:
                           return 50
                       case .medium:
                           return 50
                       case .difficult:
                           return 50
                   }

               
               case .degree1:
                   switch gameModeEnum {
                       case .easy:
                           return 30
                       case .medium:
                           return 30
                       case .difficult:
                           return 30
                   }
               case .degree2:
                   switch gameModeEnum {
                       case .easy:
                           return 40
                       case .medium:
                           return 40
                       case .difficult:
                           return 40
                   }
               case .degree3:
                   switch gameModeEnum {
                       case .easy:
                           return 50
                       case .medium:
                           return 50
                       case .difficult:
                           return 50
                   }
               case .degree4:
                   switch gameModeEnum {
                       case .easy:
                           return 60
                       case .medium:
                           return 60
                       case .difficult:
                           return 60
                   }
               }
    }
}

