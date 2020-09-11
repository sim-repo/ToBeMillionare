import UIKit



class SpaceshipEnvStaticLayer: UIView {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func draw(_ rect: CGRect) {
        if ScreenResolutionsEnum.screen() == .screen_47 {
            SpaceshipEnvironmentScreen.drawSpaceshipStaticLayer_47(frame: bounds)
        } else
        
        if ScreenResolutionsEnum.screen() == .screen_55 {
            SpaceshipEnvironmentScreen.drawSpaceshipStaticLayer_55(frame: bounds)
        } else
        
        if ScreenResolutionsEnum.screen() == .screen_58 {
            SpaceshipEnvironmentScreen.drawSpaceshipStaticLayer_58(frame: bounds)
        } else
        
        if ScreenResolutionsEnum.screen() == .screen_65 {
            SpaceshipEnvironmentScreen.drawSpaceshipStaticLayer_65(frame: bounds)
        }
    }
}





