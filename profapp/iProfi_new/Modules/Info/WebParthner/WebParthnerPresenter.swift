//
//  WebParthnerPresenter.swift
//  iProfi_new
//
//  Created by violy on 23.09.2022.
//

import Foundation

protocol WebParthnerPresenterProtocol {
    var router: WebParthnerRouterProtocol! { get set }
    func configureView()
    func backAction()
}

class WebParthnerPresenter: WebParthnerPresenterProtocol {
    var router: WebParthnerRouterProtocol!
    var interactor: WebParthnerInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
}
