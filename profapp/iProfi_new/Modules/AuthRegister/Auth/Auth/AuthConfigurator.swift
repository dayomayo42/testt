//
//  AuthConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 28.08.2020.
//

import Foundation
import UIKit

protocol AuthConfiguratorProtocol: class {
    func configure(with viewController: AuthController)
}

class AuthConfigurator: AuthConfiguratorProtocol {
    func configure(with viewController: AuthController) {
        let presenter = AuthPresenter()
        let interactor = AuthInteractor(viewController: viewController, presenter: presenter)
        let router = AuthRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
