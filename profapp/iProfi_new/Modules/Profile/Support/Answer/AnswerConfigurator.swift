//
//  AnswerConfigurator.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 27.10.2020.
//

import Foundation
import UIKit

protocol AnswerConfiguratorProtocol: class {
    func configure(with viewController: AnswerController)
}

class AnswerConfigurator: AnswerConfiguratorProtocol {
    func configure(with viewController: AnswerController) {
        let presenter = AnswerPresenter()
        let interactor = AnswerInteractor(viewController: viewController, presenter: presenter)
        let router = AnswerRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

