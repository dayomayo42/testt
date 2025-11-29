//
//  ServicesPresenteer.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 15.10.2020.
//

import Foundation
import UIKit

protocol ServicesPresenterProtocol: class {
    var router: ServicesRouterProtocol! { get set }
    func configureView()
    func backAction()
    func openDetail(model: Service)
    func addService()
    func getServices()
    func shareLink()
}

class ServicesPresenter: ServicesPresenterProtocol {
    var router: ServicesRouterProtocol!
    var interactor: ServicesInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func openDetail(model: Service) {
        interactor.openDetail(model: model)
    }
    
    func addService() {
        interactor.addService()
    }
    
    func getServices() {
        interactor.getServices()
    }
    
    func shareLink() {
        interactor.shareLink()
    }
}

