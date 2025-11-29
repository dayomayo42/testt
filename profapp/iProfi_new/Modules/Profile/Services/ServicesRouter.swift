//
//  ServicesRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 15.10.2020.
//

import Foundation
import UIKit

protocol ServicesRouterProtocol: class {
    func backAction()
}

class ServicesRouter: ServicesRouterProtocol {
    weak var viewController: ServicesController!
    
    init(viewController: ServicesController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}


