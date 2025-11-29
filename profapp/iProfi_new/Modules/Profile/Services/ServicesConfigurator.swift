//
//  ServicesConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 15.10.2020.
//

import Foundation
import UIKit

protocol ServicesConfiguratorProtocol: class {
    func configure(with viewController: ServicesController)
}

class ServicesConfigurator: ServicesConfiguratorProtocol {
    func configure(with viewController: ServicesController) {
        let presenter = ServicesPresenter()
        let interactor = ServicesInteractor(viewController: viewController, presenter: presenter)
        let router = ServicesRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

