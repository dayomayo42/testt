//
//  FinancePresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 02.11.2020.
//

import Foundation
import UIKit

protocol FinancePresenterProtocol: class {
    var router: FinanceRouterProtocol! { get set }
    func configureView()
    func backAction()
    func openDetail(with title: String)
}

class FinancePresenter: FinancePresenterProtocol {
    var router: FinanceRouterProtocol!
    var interactor: FinanceInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func openDetail(with title: String) {
        interactor.openDetail(with: title)
    }
}

