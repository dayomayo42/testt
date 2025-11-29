//
//  FinanceRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 02.11.2020.
//

import Foundation
import UIKit

protocol FinanceRouterProtocol: class {
    func backAction()
}

class FinanceRouter: FinanceRouterProtocol {
    weak var viewController: FinanceController!
    
    init(viewController: FinanceController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}


