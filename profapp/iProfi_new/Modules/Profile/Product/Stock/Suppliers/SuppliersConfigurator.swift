//
//  SuppliersConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 15.10.2020.
//

import Foundation
import UIKit

protocol SuppliersConfiguratorProtocol: class {
    func configure(with viewController: SuppliersController)
}

class SuppliersConfigurator: SuppliersConfiguratorProtocol {
    func configure(with viewController: SuppliersController) {
        let presenter = SuppliersPresenter()
        let interactor = SuppliersInteractor(viewController: viewController, presenter: presenter)
        let router = SuppliersRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

