//
//  StudyConfigurator.swift
//  iProfi_new
//
//  Created by violy on 11.08.2022.
//

import Foundation

protocol StudyConfiguratorProtocol {
    func configure(with viewController: StudyViewController)
}

class StudyConfigurator: StudyConfiguratorProtocol {
    func configure(with viewController: StudyViewController) {
        let presenter = StudyPresenter()
        let interactor = StudyInteractor(viewController: viewController, presenter: presenter)
        let router = StudyRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
