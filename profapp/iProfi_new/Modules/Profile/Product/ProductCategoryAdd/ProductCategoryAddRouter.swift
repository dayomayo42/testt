//
//  ProductCategoryAddRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 08.10.2020.
//

import Foundation
import UIKit

protocol ProductCategoryAddRouterProtocol: class {
    func backAction()
}

class ProductCategoryAddRouter: ProductCategoryAddRouterProtocol {
    weak var viewController: ProductCategoryAddController!

    init(viewController: ProductCategoryAddController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}

