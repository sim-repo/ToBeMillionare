import Foundation


// Class-Factory for creating and storing presenters
class PresenterFactory {
    
    static let shared = PresenterFactory()
    private init(){}

    // store
    private lazy var presenters: [ModuleEnum:PresenterProtocol] = [:]
    

    // called from Anywhere:
    public func getInstance<T: PresenterProtocol>() -> T {
        if let presenter: T = getPresenter() {
            return presenter
        }
        
        let presenter: T = T()
        let moduleEnum = ModuleEnum(presenter: presenter)
        presenters[moduleEnum] = presenter
        return presenter
    }
    
    
    public func getPresenter<T: PresenterProtocol>() -> T? {
        let presenterEnum = ModuleEnum(presenterType: T.self)
        let res: T? = presenters[presenterEnum] as? T
        return res
    }
    
    
    
    // called from VC
    public func getPresenter(viewDidLoad vc: PresentableView) -> ViewablePresenter {
        
        let moduleEnum = ModuleEnum(vc: vc)
        
        if let presenter = presenters[moduleEnum] as? ViewablePresenter {
            presenter.setView(vc: vc)
            return presenter
        }
        return createPresenter(clazz: moduleEnum.presenter, vc) as! ViewablePresenter
    }
    
    
    
    // private methods
    private func createPresenter(clazz: PresenterProtocol.Type, _ vc: PresentableView) -> PresenterProtocol {
        
        let presenter = clazz.init()
        let moduleEnum = ModuleEnum(presenter: presenter)
        presenters[moduleEnum] = presenter
        (presenter as! ViewablePresenter).setView(vc: vc)
        return presenter
    }
}
