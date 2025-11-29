//
//  UpdateScreenConfiguration.swift
//  iProfi_new
//
//  Created by violy on 19.01.2023.
//

import Foundation

protocol UpdateScreenConfiguratorProtocol {
    func configure(with viewController: UpdateScreenViewController)
}

class UpdateScreenConfigurator: UpdateScreenConfiguratorProtocol {
    func configure(with viewController: UpdateScreenViewController) {
        let presenter = UpdateScreenPresenter()
        let interactor = UpdateScreenInteractor(viewController: viewController, presenter: presenter)
        let router = Router(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
