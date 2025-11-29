//
//  ServiceAddPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 15.10.2020.
//

import Foundation
import UIKit

protocol ServiceAddPresenterProtocol: class {
    var router: ServiceAddRouterProtocol! { get set }
    func configureView()
    func backAction()
    func checkField()
    func addService()
}

class ServiceAddPresenter: ServiceAddPresenterProtocol {
    var router: ServiceAddRouterProtocol!
    var interactor: ServiceAddInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func checkField() {
        interactor.checkField()
    }
    
    func addService() {
        interactor.addService()
    }
}

