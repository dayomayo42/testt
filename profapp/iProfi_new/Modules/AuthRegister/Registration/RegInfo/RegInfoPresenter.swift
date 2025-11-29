//
//  RegInfoPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 09.09.2020.
//

import Foundation

protocol RegInfoPresenterProtocol: class {
    var router: RegInfoRouterProtocol! {get set}
    func configureView()
    func configureView(with model: SphereModel)
    func openSphere()
    func registerAction()
    func setActive(active: Bool)
    func checkField(text: String)
}

class RegInfoPresenter: RegInfoPresenterProtocol {
    var router: RegInfoRouterProtocol!
    var interactor: RegInfoInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func openSphere() {
        interactor.openSphere()
    }
    
    func registerAction() {
        interactor.registerAction()
    }
    
    func configureView(with model: SphereModel) {
        interactor.configureView(with: model)
    }
    
    func setActive(active: Bool) {
        interactor.setActive(active: active)
    }
    
    func checkField(text: String) {
        interactor.checkField(text: text)
    }
}
