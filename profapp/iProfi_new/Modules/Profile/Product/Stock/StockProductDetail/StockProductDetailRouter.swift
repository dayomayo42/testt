//
//  StockProductDetailRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 09.11.2020.
//

import Foundation
import UIKit

protocol StockProductDetailRouterProtocol: class {
    func backAction()
}

class StockProductDetailRouter: StockProductDetailRouterProtocol {
    weak var viewController: StockProductDetailController!
    
    init(viewController: StockProductDetailController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}



