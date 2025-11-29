//
//  StockAllOrdersRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 11.11.2020.
//

import Foundation
import UIKit

protocol StockAllOrdersRouterProtocol: class {
    func backAction()
}

class StockAllOrdersRouter: StockAllOrdersRouterProtocol {
    weak var viewController: StockAllOrdersController!
    
    init(viewController: StockAllOrdersController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}



