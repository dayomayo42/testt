//
//  FeedbackConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 27.10.2020.
//

import Foundation
import UIKit

protocol FeedbackConfiguratorProtocol: class {
    func configure(with viewController: FeedbackController)
}

class FeedbackConfigurator: FeedbackConfiguratorProtocol {
    func configure(with viewController: FeedbackController) {
        let presenter = FeedbackPresenter()
        let interactor = FeedbackInteractor(viewController: viewController, presenter: presenter)
        let router = FeedbackRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

