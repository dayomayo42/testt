//
//  ContactListConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 30.11.2020.
//

import Foundation
import UIKit

protocol ContactListConfiguratorProtocol: class {
    func configure(with viewController: ContactListController)
}

class ContactListConfigurator: ContactListConfiguratorProtocol {
    func configure(with viewController: ContactListController) {
        let presenter = ContactListPresenter()
        let interactor = ContactListInteractor(viewController: viewController, presenter: presenter)
        let router = ContactListRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

