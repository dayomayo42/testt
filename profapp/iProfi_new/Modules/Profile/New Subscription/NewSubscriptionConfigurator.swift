//
//  NewSubscriptionConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 21.04.2022.
//

import Foundation
import UIKit

protocol NewSubscriptionConfiguratorProtocol {
    func configure(with viewController: NewSubscriptionController)
}

class NewSubscriptionConfigurator: NewSubscriptionConfiguratorProtocol {
    func configure(with viewController: NewSubscriptionController) {
        let presenter = NewSubscriptionPresenter()
        let interactor = NewSubscriptionInteractor(viewController: viewController, presenter: presenter)
        let router = NewSubscriptionRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

