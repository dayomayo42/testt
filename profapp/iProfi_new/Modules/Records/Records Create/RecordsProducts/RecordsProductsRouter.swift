//
//  RecordsProductsRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 26.10.2020.
//

import Foundation
import UIKit

protocol RecordsProductsRouterProtocol: class {
    func backAction()
}

class RecordsProductsRouter: RecordsProductsRouterProtocol {
    weak var viewController: RecordsProductsController!
    
    init(viewController: RecordsProductsController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}


