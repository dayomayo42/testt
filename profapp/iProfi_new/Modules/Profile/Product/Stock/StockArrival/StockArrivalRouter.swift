//
//  StockArrivalRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 11.12.2020.
//

import Foundation
import UIKit

protocol StockArrivalRouterProtocol: class {
    func backAction()
}

class StockArrivalRouter: StockArrivalRouterProtocol {
    weak var viewController: StockArrivalController!
    
    init(viewController: StockArrivalController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}



