//
//  LaunchConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 28.08.2020.
//

import Foundation
import UIKit

protocol LaunchConfiguratorProtocol: class {
    func configure(with viewController: LaunchController)
}

class LaunchConfigurator: LaunchConfiguratorProtocol {
    func configure(with viewController: LaunchController) {
        let presenter = LaunchPresenter()
        let interactor = LaunchInteractor(viewController: viewController, presenter: presenter)
        let router = LaunchRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
