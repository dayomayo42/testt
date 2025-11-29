//
//  RecordsCreateConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 06.10.2020.
//

import Foundation
import UIKit

protocol RecordsCreateConfiguratorProtocol: class {
    func configure(with viewController: RecordsCreateController)
}

class RecordsCreateConfigurator: RecordsCreateConfiguratorProtocol {
    func configure(with viewController: RecordsCreateController) {
        let presenter = RecordsCreatePresenter()
        let interactor = RecordsCreateInteractor(viewController: viewController, presenter: presenter)
        let router = RecordsCreateRouter(viewController: viewController)

        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
