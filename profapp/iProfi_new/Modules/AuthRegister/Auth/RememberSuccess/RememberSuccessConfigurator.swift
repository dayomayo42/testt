//
//  RememberSuccessConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 02.09.2020.
//

import Foundation
import UIKit

protocol RememberSuccessConfiguratorProtocol: class {
    func configure(with viewController: RememberSuccessController)
}

class RememberSuccessConfigurator: RememberSuccessConfiguratorProtocol {
    func configure(with viewController: RememberSuccessController) {
        let presenter = RememberSuccessPresenter()
        let interactor = RememberSuccessInteractor(viewController: viewController, presenter: presenter)
        let router = RememberSuccessRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
