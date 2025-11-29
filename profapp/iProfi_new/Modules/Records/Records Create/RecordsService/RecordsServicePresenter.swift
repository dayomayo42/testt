//
//  RecordsServicePresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 26.10.2020.
//

import Foundation
import UIKit

protocol RecordsServicePresenterProtocol: class {
    var router: RecordsServiceRouterProtocol! { get set }
    func configureView()
    func backAction()
    func checkCacheServices()
    func getServices()
    func addService()
    func chooseService()
    func search(string: String)
}

class RecordsServicePresenter: RecordsServicePresenterProtocol {
    var router: RecordsServiceRouterProtocol!
    var interactor: RecordsServiceInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func checkCacheServices() {
        interactor.checkCacheServices()
    }
    
    func getServices() {
        interactor.getServices()
    }
    
    func addService() {
        interactor.addService()
    }
    
    func chooseService() {
        interactor.chooseService()
    }
    
    func search(string: String) {
        interactor.search(string: string)
    }
}

