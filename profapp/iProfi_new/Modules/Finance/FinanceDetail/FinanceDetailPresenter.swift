//
//  FinanceDetailPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 02.11.2020.
//

import Foundation
import UIKit

protocol FinanceDetailPresenterProtocol: class {
    var router: FinanceDetailRouterProtocol! { get set }
    func configureView()
    func backAction()
    func addAction(income: Bool)
    func getFinance(type: String, date: String)
    func clearStack()
    func postDelete(id: Int)
}

class FinanceDetailPresenter: FinanceDetailPresenterProtocol {
    var router: FinanceDetailRouterProtocol!
    var interactor: FinanceDetailInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func addAction(income: Bool) {
        interactor.addAction(income: income)
    }
    
    func getFinance(type: String, date: String) {
        interactor.getFinance(type: type, date: date)
    }
    
    func clearStack() {
        interactor.clearStack()
    }
    
    func postDelete(id: Int) {
        interactor.postDelete(id: id)
    }
}

