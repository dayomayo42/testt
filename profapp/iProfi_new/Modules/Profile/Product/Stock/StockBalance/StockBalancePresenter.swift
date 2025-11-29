//
//  StockBalancePresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 16.12.2020.
//

import Foundation
import UIKit

protocol StockBalancePresenterProtocol: class {
    var router: StockBalanceRouterProtocol! { get set }
    func configureView()
    func backAction()
    func getProducts()
}

class StockBalancePresenter: StockBalancePresenterProtocol {
    var router: StockBalanceRouterProtocol!
    var interactor: StockBalanceInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func getProducts() {
        interactor.getProducts()
    }
}


