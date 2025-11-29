//
//  StockDebtsPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 11.11.2020.
//

import Foundation
import UIKit

protocol StockDebtsPresenterProtocol: class {
    var router: StockDebtsRouterProtocol! { get set }
    func configureView()
    func backAction()
    func openDetail(with model: DebtsUser)
    func getDebtors()
}

class StockDebtsPresenter: StockDebtsPresenterProtocol {
    var router: StockDebtsRouterProtocol!
    var interactor: StockDebtsInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func openDetail(with model: DebtsUser) {
        interactor.openDetail(with: model)
    }
    
    func getDebtors() {
        interactor.getDebtors()
    }
}


