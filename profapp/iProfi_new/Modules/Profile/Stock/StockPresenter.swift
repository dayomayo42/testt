//
//  StockPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 28.04.2021.
//

import Foundation
import UIKit

protocol StockPresenterProtocol: class {
    var router: StockRouterProtocol! { get set }
    func configureView()
    func backAction()
    
    func supplierDirectory()
    func productCatalog()
    func productArrival()
    func productConsumption()
    func productRemaining()
    func productOrders()
    func openSubs()
}

class StockPresenter: StockPresenterProtocol {
    var router: StockRouterProtocol!
    var interactor: StockInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func supplierDirectory() {
        interactor.supplierDirectory()
    }
    
    func productCatalog() {
        interactor.productCatalog()
    }
    
    func productArrival() {
        interactor.productArrival()
    }
    
    func productConsumption() {
        interactor.productConsumption()
    }
    
    func productRemaining() {
        interactor.productRemaining()
    }
    
    func productOrders() {
        interactor.productOrders()
    }
    
    func openSubs() {
        router.openSubs()
    }
}


