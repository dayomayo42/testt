//
//  StockOrdersRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 10.11.2020.
//

import Foundation
import UIKit

protocol StockOrdersRouterProtocol: class {
    func backAction()
}

class StockOrdersRouter: StockOrdersRouterProtocol {
    weak var viewController: StockOrdersController!
    
    init(viewController: StockOrdersController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}



