//
//  NotificationDetailConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 03.12.2020.
//

import Foundation
import UIKit

protocol NotificationDetailConfiguratorProtocol: class {
    func configure(with viewController: NotificationDetailController)
}

class NotificationDetailConfigurator: NotificationDetailConfiguratorProtocol {
    func configure(with viewController: NotificationDetailController) {
        let presenter = NotificationDetailPresenter()
        let interactor = NotificationDetailInteractor(viewController: viewController, presenter: presenter)
        let router = NotificationDetailRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

