//
//  SubscribeTrialConfigurator.swift
//  iProfi_new
//
//  Created by violy on 20.01.2023.
//

import Foundation

protocol SubscribeTrialConfiguratorProtocol {
    func configure(with viewController: SubscribeTrialViewController)
}

class SubscribeTrialConfigurator: SubscribeTrialConfiguratorProtocol {
    func configure(with viewController: SubscribeTrialViewController) {
        let presenter = SubscribeTrialPresenter()
        let interactor = SubscribeTrialInteractor(viewController: viewController, presenter: presenter)
        let router = SubscribeTrialRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
