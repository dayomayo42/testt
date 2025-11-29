//
//  LiveJournalConfigurator.swift
//  iProfi_new
//
//  Created by violy on 16.08.2022.
//

import Foundation

protocol LiveJournalConfiguratorProtocol {
    func configure(with viewController: LiveJournalController)
}

class LiveJournalConfigurator: LiveJournalConfiguratorProtocol {
    func configure(with viewController: LiveJournalController) {
        let presenter = LiveJournalPresenter()
        let interactor = LiveJournalInteractor(viewController: viewController, presenter: presenter)
        let router = LiveJournalRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
