//
//  ServiceAddConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 15.10.2020.
//

import Foundation
import UIKit

protocol ServiceAddConfiguratorProtocol: class {
    func configure(with viewController: ServiceAddController)
}

class ServiceAddConfigurator: ServiceAddConfiguratorProtocol {
    func configure(with viewController: ServiceAddController) {
        let presenter = ServiceAddPresenter()
        let interactor = ServiceAddInteractor(viewController: viewController, presenter: presenter)
        let router = ServiceAddRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

