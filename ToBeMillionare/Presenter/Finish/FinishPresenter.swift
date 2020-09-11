//
//  FinishPresenter.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 18.06.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import Foundation

final class FinishPresenter {
    
    private weak var vc: PresentableFinishView?
    
    private var profilePresenter: ReadableProfilePresenter {
        let profilePresenter: ProfilePresenter = PresenterFactory.shared.getInstance()
        return profilePresenter
    }
    
    private var playPresenter: ReadablePlayPresenter {
        let presenter: PlayPresenter = PresenterFactory.shared.getInstance()
        return presenter as ReadablePlayPresenter
    }
}


//MARK:- Viewable

extension FinishPresenter: ViewableFinishPresenter {
    
    func setView(vc: PresentableView) {
        self.vc = vc as? PresentableFinishView
    }
    
    func getPlayerName() -> String {
        return profilePresenter.getSelected().getName()
    }
    
    func getAward() -> Double {
        return playPresenter.getAward()
    }
}
