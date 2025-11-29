//
//  RegSpherePresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 11.09.2020.
//

import Foundation

protocol RegSpherePresenterProtocol: class {
    var router: RegSphereRouterProtocol! {get set}
    func configureView()
    func dismissAction()
}

class RegSpherePresenter: RegSpherePresenterProtocol {
    var router: RegSphereRouterProtocol!
    var interactor: RegSphereInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func dismissAction() {
        router.dismiss()
    }
}
