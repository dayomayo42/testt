//
//  MyStudyConfigurator.swift
//  iProfi_new
//
//  Created by violy on 12.08.2022.
//

import Foundation

protocol MyStudyConfiguratorProtocol {
    func configure(with viewController: MyStudyController)
}

class MyStudyConfigurator: MyStudyConfiguratorProtocol {
    func configure(with viewController: MyStudyController) {
        let presenter = MyStudyPresenter()
        let interactor = MyStudyInteractor(viewController: viewController, presenter: presenter)
        let router = MyStudyRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
