//
//  SpecConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 24.10.2020.
//

import Foundation
import UIKit

protocol SpecConfiguratorProtocol: class {
    func configure(with viewController: SpecController)
}

class SpecConfigurator: SpecConfiguratorProtocol {
    func configure(with viewController: SpecController) {
        let presenter = SpecPresenter()
        let interactor = SpecInteractor(viewController: viewController, presenter: presenter)
        let router = SpecRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

