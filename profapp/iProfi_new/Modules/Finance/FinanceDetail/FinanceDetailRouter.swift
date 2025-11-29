//
//  FinanceDetailRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 02.11.2020.
//

import Foundation
import UIKit

protocol FinanceDetailRouterProtocol: class {
    func backAction()
}

class FinanceDetailRouter: FinanceDetailRouterProtocol {
    weak var viewController: FinanceDetailController!
    
    init(viewController: FinanceDetailController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}


