//
//  RemamberPassConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 01.09.2020.
//

import Foundation
import UIKit

protocol RememberPassConfiguratorProtocol: class {
    func configure(with viewController: RememberPassController)
}

class RememberPassConfigurator: RememberPassConfiguratorProtocol {
    func configure(with viewController: RememberPassController) {
        let presenter = RememberPassPresenter()
        let interactor = RememberPassInteractor(viewController: viewController, presenter: presenter)
        let router = RememberPassRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
