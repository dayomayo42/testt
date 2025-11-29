//
//  ProductDetailRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 13.10.2020.
//

import Foundation
import UIKit

protocol ProductDetailRouterProtocol: class {
    func backAction()
}

class ProductDetailRouter: ProductDetailRouterProtocol {
    weak var viewController: ProductDetailController!
    
    init(viewController: ProductDetailController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}


