//
//  StockConsumptionRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 11.12.2020.
//

import Foundation
import UIKit

protocol StockConsumptionRouterProtocol: class {
    func backAction()
}

class StockConsumptionRouter: StockConsumptionRouterProtocol {
    weak var viewController: StockConsumptionController!
    
    init(viewController: StockConsumptionController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}



