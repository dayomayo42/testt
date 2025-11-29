//
//  SalesCategoryNextcConfigurator.swift
//  iProfi_new
//
//  Created by violy on 15.08.2022.
//

import Foundation

protocol SalesCategoryNextConfiguratorProtocol {
    func configure(with viewController: SalesCategoryNextController)
}

class SalesCategoryNextConfigurator: SalesCategoryNextConfiguratorProtocol {
    func configure(with viewController: SalesCategoryNextController) {
        let presenter = SalesCategoryNextPresenter()
        let interactor = SalesCategoryNextInteractor(viewController: viewController, presenter: presenter)
        let router = SalesCategoryNextRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
