//
//  NotificationSettingsConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 09.12.2020.
//

import Foundation
import UIKit

protocol NotificationSettingsConfiguratorProtocol: class {
    func configure(with viewController: NotificationSettingsController)
}

class NotificationSettingsConfigurator: NotificationSettingsConfiguratorProtocol {
    func configure(with viewController: NotificationSettingsController) {
        let presenter = NotificationSettingsPresenter()
        let interactor = NotificationSettingsInteractor(viewController: viewController, presenter: presenter)
        let router = NotificationSettingsRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

