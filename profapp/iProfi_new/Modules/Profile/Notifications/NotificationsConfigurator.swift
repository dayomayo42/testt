//
//  NotificationsConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 02.12.2020.
//

import Foundation
import UIKit

protocol NotificationsConfiguratorProtocol: class {
    func configure(with viewController: NotificationsController)
}

class NotificationsConfigurator: NotificationsConfiguratorProtocol {
    func configure(with viewController: NotificationsController) {
        let presenter = NotificationsPresenter()
        let interactor = NotificationsInteractor(viewController: viewController, presenter: presenter)
        let router = NotificationsRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

