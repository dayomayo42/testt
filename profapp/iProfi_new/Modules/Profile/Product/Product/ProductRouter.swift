//
//  ProductRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 07.10.2020.
//

import Foundation
import UIKit

protocol ProductRouterProtocol: class {
    func backAction()
}

class ProductRouter: ProductRouterProtocol {
    weak var viewController: ProductController!

    init(viewController: ProductController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}

