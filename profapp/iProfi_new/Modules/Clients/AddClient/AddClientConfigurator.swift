//
//  AddClientConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 25.10.2020.
//

import Foundation
import UIKit

protocol AddClientConfiguratorProtocol: class {
    func configure(with viewController: AddClientController)
}

class AddClientConfigurator: AddClientConfiguratorProtocol {
    func configure(with viewController: AddClientController) {
        let presenter = AddClientPresenter()
        let interactor = AddClientInteractor(viewController: viewController, presenter: presenter)
        let router = AddClientRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

