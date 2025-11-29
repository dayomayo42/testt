//
//  StockAllOrdersPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 11.11.2020.
//

import Foundation
import UIKit

protocol StockAllOrdersPresenterProtocol: class {
    var router: StockAllOrdersRouterProtocol! { get set }
    func configureView()
    func backAction()
    func chooseFilter()
    func getOrders()
    func sortTo(type: String)
    func openDetail(model: StockOrder)
}

class StockAllOrdersPresenter: StockAllOrdersPresenterProtocol {
    var router: StockAllOrdersRouterProtocol!
    var interactor: StockAllOrdersInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func chooseFilter() {
        interactor.chooseFilter()
    }
    
    func getOrders() {
        interactor.getOrders()
    }
    
    func sortTo(type: String) {
        interactor.sortTo(type: type)
    }
    
    func openDetail(model: StockOrder) {
        interactor.openDetail(model: model)
    }
}


