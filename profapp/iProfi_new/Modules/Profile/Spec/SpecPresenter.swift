//
//  SpecPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 24.10.2020.
//

import Foundation
import UIKit

protocol SpecPresenterProtocol: class {
    var router: SpecRouterProtocol! { get set }
    func configureView()
    func backAction()
    func getSpec()
    func selectSpec(spec: Spec)
}

class SpecPresenter: SpecPresenterProtocol {
    var router: SpecRouterProtocol!
    var interactor: SpecInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func getSpec() {
        interactor.getSpec()
    }
    
    func selectSpec(spec: Spec) {
        router.selectSpec(spec: spec)
    }
    
}

