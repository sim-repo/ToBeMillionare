import UIKit


class LogoStatic: UIView {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        if ScreenResolutionsEnum.screen() == .screen_65 {
            LogoScreen.drawStaticBkg_65(frame: bounds, resizing: .aspectFit)
        } else if ScreenResolutionsEnum.screen() == .screen_58 {
            LogoScreen.drawStaticBkg_58(frame: bounds, resizing: .aspectFit)
            
        } else if ScreenResolutionsEnum.screen() == .screen_55 {
            LogoScreen.drawStaticBkg_55(frame: bounds, resizing: .aspectFit)
            
        } else if ScreenResolutionsEnum.screen() == .screen_47 {
            LogoScreen.drawStaticBkg_47(frame: bounds, resizing: .aspectFit)
        }
    }
    
}


