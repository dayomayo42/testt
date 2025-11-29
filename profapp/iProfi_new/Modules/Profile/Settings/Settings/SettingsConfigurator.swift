//
//  SettingsConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 03.11.2020.
//

import Foundation
import UIKit

protocol SettingsConfiguratorProtocol: class {
    func configure(with viewController: SettingsController)
}

class SettingsConfigurator: SettingsConfiguratorProtocol {
    func configure(with viewController: SettingsController) {
        let presenter = SettingsPresenter()
        let interactor = SettingsInteractor(viewController: viewController, presenter: presenter)
        let router = SettingsRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

