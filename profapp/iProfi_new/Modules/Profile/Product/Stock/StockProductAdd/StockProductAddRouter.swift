//
//  StockProductAddRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 06.11.2020.
//

import Foundation
import UIKit

protocol StockProductAddRouterProtocol: class {
    func backAction()
}

class StockProductAddRouter: StockProductAddRouterProtocol {
    weak var viewController: StockProductAddController!
    
    init(viewController: StockProductAddController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}


