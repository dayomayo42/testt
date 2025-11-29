//
//  StockDebtsRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 11.11.2020.
//

import Foundation
import UIKit

protocol StockDebtsRouterProtocol: class {
    func backAction()
}

class StockDebtsRouter: StockDebtsRouterProtocol {
    weak var viewController: StockDebtsController!
    
    init(viewController: StockDebtsController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}



