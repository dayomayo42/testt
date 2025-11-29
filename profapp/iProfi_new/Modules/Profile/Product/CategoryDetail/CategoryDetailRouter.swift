//
//  CatgoryDetailRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 12.10.2020.
//

import Foundation
import UIKit

protocol CategoryDetailRouterProtocol: class {
    func backAction()
}

class CategoryDetailRouter: CategoryDetailRouterProtocol {
    weak var viewController: CategoryDetailController!

    init(viewController: CategoryDetailController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}

