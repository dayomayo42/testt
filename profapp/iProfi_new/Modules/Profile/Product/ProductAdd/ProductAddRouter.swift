//
//  ProductDetailRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 12.10.2020.
//

import Foundation
import UIKit

protocol ProductAddRouterProtocol: class {
    func backAction()
}

class ProductAddRouter: ProductAddRouterProtocol {
    weak var viewController: ProductAddController!
    
    init(viewController: ProductAddController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}


