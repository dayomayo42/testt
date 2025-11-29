//
//  FinanceAddConsumptionPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 02.11.2020.
//

import Foundation
import UIKit

protocol FinanceAddConsumptionPresenterProtocol: class {
    var router: FinanceAddConsumptionRouterProtocol! { get set }
    func configureView()
    func backAction()
    func checkField()
    func postFinance(type: String, name: String, price: Int, comment: String)
}

class FinanceAddConsumptionPresenter: FinanceAddConsumptionPresenterProtocol {
    var router: FinanceAddConsumptionRouterProtocol!
    var interactor: FinanceAddConsumptionInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func checkField() {
        interactor.checkField()
    }
    
    func postFinance(type: String, name: String, price: Int, comment: String)  {
        interactor.postFinance(type: type, name: name, price: price, comment: comment)
    }
}

