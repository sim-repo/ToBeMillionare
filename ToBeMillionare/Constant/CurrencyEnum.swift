import Foundation

enum CurrencyEnum: String {
    
    case dollar, euro, iena, pound, ruble, rupee, shekel, none
    
    
    public static func getCurrency(stage: Int) -> CurrencyEnum {
        switch stage {
            case 1:
                return dollar
            case 2:
                return euro
            case 3:
                return iena
            case 4:
                return pound
            case 5:
                return ruble
            case 6:
                return rupee
            case 7:
                return shekel
            default:
                return none
        }
    }
    
    public static func getCurrencySymbol(currencyEnum: CurrencyEnum) -> String {
        switch currencyEnum {
            case .dollar:
                return "$"
            case .euro:
                return "€"
            case .iena:
                return "¥"
            case .pound:
                return "£"
            case .ruble:
                return "₽"
            case .rupee:
                return "₹"
            case .shekel:
                return "₪"
            case .none:
                return "⚡︎"
        }
    }
}
