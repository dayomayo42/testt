//
//  StudyDetailCinfigurator.swift
//  iProfi_new
//
//  Created by violy on 12.08.2022.
//

import Foundation

protocol StudyDetailConfiguratorProtocol {
    func configure(with viewController: StudyDetailController)
}

class StudyDetailConfigurator: StudyDetailConfiguratorProtocol {
    func configure(with viewController: StudyDetailController) {
        let presenter = StudyDetailPresenter()
        let interactor = StudyDetailInteractor(viewController: viewController, presenter: presenter)
        let router = StudyDetailRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
