//
//  FinanceDetailConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 02.11.2020.
//

import Foundation
import UIKit

protocol FinanceDetailConfiguratorProtocol: class {
    func configure(with viewController: FinanceDetailController)
}

class FinanceDetailConfigurator: FinanceDetailConfiguratorProtocol {
    func configure(with viewController: FinanceDetailController) {
        let presenter = FinanceDetailPresenter()
        let interactor = FinanceDetailInteractor(viewController: viewController, presenter: presenter)
        let router = FinanceDetailRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

