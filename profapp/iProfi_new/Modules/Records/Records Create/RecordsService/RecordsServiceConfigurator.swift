//
//  RecordsServiceConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 26.10.2020.
//

import Foundation
import UIKit

protocol RecordsServiceConfiguratorProtocol: class {
    func configure(with viewController: RecordsServiceController)
}

class RecordsServiceConfigurator: RecordsServiceConfiguratorProtocol {
    func configure(with viewController: RecordsServiceController) {
        let presenter = RecordsServicePresenter()
        let interactor = RecordsServiceInteractor(viewController: viewController, presenter: presenter)
        let router = RecordsServiceRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

