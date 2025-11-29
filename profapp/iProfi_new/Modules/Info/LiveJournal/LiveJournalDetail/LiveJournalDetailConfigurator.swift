//
//  LiveJournalDetailConfigurator.swift
//  iProfi_new
//
//  Created by violy on 16.08.2022.
//

import Foundation

protocol LiveJournalDetailConfiguratorProtocol {
    func configure(with viewController: LiveJournalDetailController)
}

class LiveJournalDetailConfigurator: LiveJournalDetailConfiguratorProtocol {
    func configure(with viewController: LiveJournalDetailController) {
        let presenter = LiveJournalDetailPresenter()
        let interactor = LiveJournalDetailInteractor(viewController: viewController, presenter: presenter)
        let router = LiveJournalDetailRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
