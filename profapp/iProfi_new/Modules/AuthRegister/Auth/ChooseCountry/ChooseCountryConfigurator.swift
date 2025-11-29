//
//  ChooseCountryConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 31.08.2020.
//

import Foundation
import UIKit

protocol ChooseCountryConfiguratorProtocol: class {
    func configure(with viewController: ChooseCountryController)
}

class ChooseCountryConfigurator: ChooseCountryConfiguratorProtocol {
    func configure(with viewController: ChooseCountryController) {
        let presenter = ChooseCountryPresenter()
        let interactor = ChooseCountryInteractor(viewController: viewController, presenter: presenter)
        let router = ChooseCountryRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
