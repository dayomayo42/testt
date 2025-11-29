//
//  UpdateScreenPresenter.swift
//  iProfi_new
//
//  Created by violy on 19.01.2023.
//

import Foundation

protocol UpdateScreenPresenterProtocol {
    var router: UpdateScreenRouterProtocol! { get set }
    func configureView()
    func backAction()
    func openItunes()
}

class UpdateScreenPresenter: UpdateScreenPresenterProtocol {
    var router: UpdateScreenRouterProtocol!
    var interactor: UpdateScreenInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func openItunes() {
        router.openItunes()
    }
}
