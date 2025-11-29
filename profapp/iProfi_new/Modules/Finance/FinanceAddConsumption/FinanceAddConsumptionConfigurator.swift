//
//  FinanceAddConsumptionConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 02.11.2020.
//

import Foundation
import UIKit

protocol FinanceAddConsumptionConfiguratorProtocol: class {
    func configure(with viewController: FinanceAddConsumptionController)
}

class FinanceAddConsumptionConfigurator: FinanceAddConsumptionConfiguratorProtocol {
    func configure(with viewController: FinanceAddConsumptionController) {
        let presenter = FinanceAddConsumptionPresenter()
        let interactor = FinanceAddConsumptionInteractor(viewController: viewController, presenter: presenter)
        let router = FinanceAddConsumptionRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

