//
//  StockOrdersInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 10.11.2020.
//

import Foundation
import UIKit

protocol StockOrdersInteractorProtocol: class {
    func configureView()
    func allOrders()
    func debts()
}

class StockOrdersInteractor: StockOrdersInteractorProtocol {
    weak var viewController: StockOrdersController!
    weak var presenter: StockOrdersPresenterProtocol!
    
    init(viewController: StockOrdersController, presenter: StockOrdersPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
    }
    
    func allOrders(){
        let vc =  viewController.getControllerProfile(controller: .stockallorders)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func debts() {
        let vc =  viewController.getControllerProfile(controller: .stockdebts)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}


