//
//  UserNotificationsConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 31.08.2021.
//

import Foundation
import UIKit

protocol UserNotificationsConfiguratorProtocol {
    func configure(with viewController: UserNotificationsController)
}

class UserNotificationsConfigurator: UserNotificationsConfiguratorProtocol {
    func configure(with viewController: UserNotificationsController) {
        let presenter = UserNotificationsPresenter()
        let interactor = UserNotificationsInteractor(viewController: viewController, presenter: presenter)
        let router = UserNotificationsRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

