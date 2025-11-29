//
//  StudyListConfigurator.swift
//  iProfi_new
//
//  Created by violy on 12.08.2022.
//

import Foundation

protocol StudyListConfiguratorProtocol {
    func configure(with viewController: StudyListController)
}

class StudyListConfigurator: StudyListConfiguratorProtocol {
    func configure(with viewController: StudyListController) {
        let presenter = StudyListPresenter()
        let interactor = StudyListInteractor(viewController: viewController, presenter: presenter)
        let router = StudyListRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
