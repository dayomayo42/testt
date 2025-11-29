//
//  SettinsController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 28.10.2020.
//

import Foundation
import UIKit

protocol SheduleConfiguratorProtocol: class {
    func configure(with viewController: SheduleController)
}

class SheduleConfigurator: SheduleConfiguratorProtocol {
    func configure(with viewController: SheduleController) {
        let presenter = ShedulePresenter()
        let interactor = SheduleInteractor(viewController: viewController, presenter: presenter)
        let router = SheduleRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

