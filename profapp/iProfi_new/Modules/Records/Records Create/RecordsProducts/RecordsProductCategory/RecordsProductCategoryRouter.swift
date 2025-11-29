//
//  RecordsProductCategoryRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 18.01.2021.
//

import Foundation
import UIKit

protocol RecordsProductCategoryRouterProtocol: class {
    func backAction()
}

class RecordsProductCategoryRouter: RecordsProductCategoryRouterProtocol {
    weak var viewController: RecordsProductCategoryController!
    
    init(viewController: RecordsProductCategoryController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}



