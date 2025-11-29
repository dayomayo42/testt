//
//  ServiceDetailСщтаашпгкфещк.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 15.10.2020.
//

import Foundation
import UIKit

protocol ServiceDetailConfiguratorProtocol: class {
    func configure(with viewController: ServiceDetailController)
}

class ServiceDetailConfigurator: ServiceDetailConfiguratorProtocol {
    func configure(with viewController: ServiceDetailController) {
        let presenter = ServiceDetailPresenter()
        let interactor = ServiceDetailInteractor(viewController: viewController, presenter: presenter)
        let router = ServiceDetailRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

