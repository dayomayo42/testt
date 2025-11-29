//
//  StockDebtsDetailPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 11.11.2020.
//

import Foundation
import UIKit

protocol StockDebtsDetailPresenterProtocol: class {
    var router: StockDebtsDetailRouterProtocol! { get set }
    func configureView()
    func backAction()
    func sortList()
    func openDetail()
}

class StockDebtsDetailPresenter: StockDebtsDetailPresenterProtocol {
    var router: StockDebtsDetailRouterProtocol!
    var interactor: StockDebtsDetailInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func sortList() {
        interactor.sortList()
    }
    
    func openDetail() {
        interactor.openDetail()
    }
}


