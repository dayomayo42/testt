//
//  SupportConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 27.10.2020.
//

import Foundation
import UIKit

protocol SupportConfiguratorProtocol: class {
    func configure(with viewController: SupportController)
}

class SupportConfigurator: SupportConfiguratorProtocol {
    func configure(with viewController: SupportController) {
        let presenter = SupportPresenter()
        let interactor = SupportInteractor(viewController: viewController, presenter: presenter)
        let router = SupportRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

