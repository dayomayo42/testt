//
//  SupplierAddRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 15.10.2020.
//

import Foundation
import UIKit

protocol SupplierAddRouterProtocol: class {
    func backAction()
}

class SupplierAddRouter: SupplierAddRouterProtocol {
    weak var viewController: SupplierAddController!
    
    init(viewController: SupplierAddController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}


