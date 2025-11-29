//
//  StockProdutsouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 06.11.2020.
//

import Foundation
import UIKit

protocol StockProdutsRouterProtocol: class {
    func backAction()
}

class StockProdutsRouter: StockProdutsRouterProtocol {
    weak var viewController: StockProdutsController!
    
    init(viewController: StockProdutsController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}


