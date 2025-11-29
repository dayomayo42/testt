//
//  StockDebtsDetailRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 11.11.2020.
//

import Foundation
import UIKit

protocol StockDebtsDetailRouterProtocol: class {
    func backAction()
}

class StockDebtsDetailRouter: StockDebtsDetailRouterProtocol {
    weak var viewController: StockDebtsDetailController!
    
    init(viewController: StockDebtsDetailController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}



