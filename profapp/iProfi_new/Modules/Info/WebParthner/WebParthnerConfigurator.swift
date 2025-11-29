//
//  File.swift
//  iProfi_new
//
//  Created by violy on 23.09.2022.
//

import Foundation

protocol WebParthnerConfiguratorProtocol {
    func configure(with viewController: WebParthnerController)
}

class WebParthnerConfigurator: WebParthnerConfiguratorProtocol {
    func configure(with viewController: WebParthnerController) {
        let presenter = WebParthnerPresenter()
        let interactor = WebParthnerInteractor(viewController: viewController, presenter: presenter)
        let router = WebParthnerRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
