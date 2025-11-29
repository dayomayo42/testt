//
//  SupplierDetailRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 16.10.2020.
//

import Foundation
import UIKit

protocol SupplierDetailRouterProtocol: class {
    func backAction()
}

class SupplierDetailRouter: SupplierDetailRouterProtocol {
    weak var viewController: SupplierDetailController!
    
    init(viewController: SupplierDetailController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}


