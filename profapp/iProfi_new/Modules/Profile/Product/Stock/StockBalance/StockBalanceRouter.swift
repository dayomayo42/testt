//
//  StockBalanceRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 16.12.2020.
//

import Foundation
import UIKit

protocol StockBalanceRouterProtocol: class {
    func backAction()
}

class StockBalanceRouter: StockBalanceRouterProtocol {
    weak var viewController: StockBalanceController!
    
    init(viewController: StockBalanceController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}



