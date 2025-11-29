//
//  FinanceAddConsumptionRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 02.11.2020.
//

import Foundation
import UIKit

protocol FinanceAddConsumptionRouterProtocol: class {
    func backAction()
}

class FinanceAddConsumptionRouter: FinanceAddConsumptionRouterProtocol {
    weak var viewController: FinanceAddConsumptionController!
    
    init(viewController: FinanceAddConsumptionController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}


