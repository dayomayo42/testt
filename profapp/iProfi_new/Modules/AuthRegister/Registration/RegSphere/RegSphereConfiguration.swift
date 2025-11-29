//
//  RegSphereConfiguration.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 11.09.2020.
//

import Foundation
import UIKit

protocol RegSphereConfiguratorProtocol: class {
    func configure(with viewController: RegSphereController)
}

class RegSphereConfigurator: RegSphereConfiguratorProtocol {
    func configure(with viewController: RegSphereController) {
        let presenter = RegSpherePresenter()
        let interactor = RegSphereInteractor(viewController: viewController, presenter: presenter)
        let router = RegSphereRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
