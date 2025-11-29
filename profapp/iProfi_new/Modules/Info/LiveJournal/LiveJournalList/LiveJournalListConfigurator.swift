//
//  LiveJournalListConfigurator.swift
//  iProfi_new
//
//  Created by violy on 16.08.2022.
//

import Foundation

protocol LiveJournalListConfiguratorProtocol {
    func configure(with viewController: LiveJournalListController)
}

class LiveJournalListConfigurator: LiveJournalListConfiguratorProtocol {
    func configure(with viewController: LiveJournalListController) {
        let presenter = LiveJournalListPresenter()
        let interactor = LiveJournalListInteractor(viewController: viewController, presenter: presenter)
        let router = LiveJournalListRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
