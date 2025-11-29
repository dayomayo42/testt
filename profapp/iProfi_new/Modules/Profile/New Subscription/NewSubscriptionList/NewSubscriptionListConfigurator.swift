//
//  NewSubscriptionListConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 18.05.2022.
//

import Foundation
import UIKit

protocol NewSubscriptionListConfiguratorProtocol {
    func configure(with viewController: NewSubscriptionListController)
}

class NewSubscriptionListConfigurator: NewSubscriptionListConfiguratorProtocol {
    func configure(with viewController: NewSubscriptionListController) {
        let presenter = NewSubscriptionListPresenter()
        let interactor = NewSubscriptionListInteractor(viewController: viewController, presenter: presenter)
        let router = NewSubscriptionListRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

