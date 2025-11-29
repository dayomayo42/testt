//
//  StockProdutsPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 06.11.2020.
//

import Foundation
import UIKit

protocol StockProdutsPresenterProtocol: class {
    var router: StockProdutsRouterProtocol! { get set }
    func configureView()
    func backAction()
    func getProducts()
    func addProduct()
    func openDetail(model: StockProduct)
    func chooseProduct(model: StockProduct)
    func search(string: String)
}

class StockProdutsPresenter: StockProdutsPresenterProtocol {
    var router: StockProdutsRouterProtocol!
    var interactor: StockProdutsInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func getProducts() {
        interactor.getProducts()
    }
    
    func addProduct() {
        interactor.addProduct()
    }
    
    func openDetail(model: StockProduct) {
        interactor.openDetail(model: model)
    }
    
    func chooseProduct(model: StockProduct) {
        interactor.chooseProduct(model: model)
    }
    
    func search(string: String) {
        interactor.search(string: string)
    }
}

