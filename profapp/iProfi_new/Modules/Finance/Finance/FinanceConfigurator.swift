//
//  FinanceConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 02.11.2020.
//

import Foundation
import UIKit

protocol FinanceConfiguratorProtocol: class {
    func configure(with viewController: FinanceController)
}

class FinanceConfigurator: FinanceConfiguratorProtocol {
    func configure(with viewController: FinanceController) {
        let presenter = FinancePresenter()
        let interactor = FinanceInteractor(viewController: viewController, presenter: presenter)
        let router = FinanceRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

