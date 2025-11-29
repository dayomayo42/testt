//
//  SubscribeTrialPresenter.swift
//  iProfi_new
//
//  Created by violy on 20.01.2023.
//

import Foundation

protocol SubscribeTrialPresenterProtocol {
    var router: SubscribeTrialRouterProtocol! { get set }
    func configureView()
    func backAction()
    func openSubscriptions()
    func openStartScreen()
}

class SubscribeTrialPresenter: SubscribeTrialPresenterProtocol {
    var router: SubscribeTrialRouterProtocol!
    var interactor: SubscribeTrialInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func openSubscriptions() {
        router.openSubscriptions()
    }
    
    func openStartScreen() {
        router.openStartScreen()
    }
}
