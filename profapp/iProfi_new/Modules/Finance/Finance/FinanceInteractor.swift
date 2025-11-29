//
//  FinanceInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 02.11.2020.
//

import Foundation
import UIKit

protocol FinanceInteractorProtocol: class {
    func configureView()
    func openDetail(with title: String)
}

class FinanceInteractor: FinanceInteractorProtocol {
    weak var viewController: FinanceController!
    weak var presenter: FinancePresenterProtocol!
    
    init(viewController: FinanceController, presenter: FinancePresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
        viewController.tableView.contentInset.top = 8
    }
    
    func openDetail(with title: String) {
        let vc = viewController.getControllerFinance(controller: .financedetail) as! FinanceDetailController
        vc.titleCategory = title
        vc.hidesBottomBarWhenPushed = true
        vc.type = title == "Чистая прибыль" ? .clearIncome : title == "Доход по услугам" ? .serviceIncome : title == "Расход по услугам" ? .serviceConsumption : title == "Доход от продукции" ? .productIncome : .otherConsumption
        
        vc.method = title == "Чистая прибыль" ? "income/clear" : title == "Доход по услугам" ? "income/services" : title == "Расход по услугам" ? "outcome/services" : title == "Доход от продукции" ? "income/products" : "outcome/other"
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}

