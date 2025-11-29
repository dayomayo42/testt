//
//  SpecializationsListConfigurator.swift
//  iProfi_new
//
//  Created by violy on 28.07.2022.
//

import Foundation

protocol SpecializationsListConfiguratorProtocol {
    func configure(with viewController: SpecializationsListController)
}

class SpecializationsListConfigurator: SpecializationsListConfiguratorProtocol {
    func configure(with viewController: SpecializationsListController) {
        let presenter = SpecializationsListPresenter()
        let interactor = SpecializationsListInteractor(viewController: viewController, presenter: presenter)
        let router = SpecializationsListRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
