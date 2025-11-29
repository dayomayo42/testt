//
//  StockOrdersPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 10.11.2020.
//

import Foundation
import UIKit

protocol StockOrdersPresenterProtocol: class {
    var router: StockOrdersRouterProtocol! { get set }
    func configureView()
    func backAction()
    func allOrders()
    func debts()
}

class StockOrdersPresenter: StockOrdersPresenterProtocol {
    var router: StockOrdersRouterProtocol!
    var interactor: StockOrdersInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func allOrders() {
        interactor.allOrders()
    }
    
    func debts() {
        interactor.debts()
    }
}


