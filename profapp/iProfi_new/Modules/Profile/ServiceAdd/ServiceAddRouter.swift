//
//  ServiceAddRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 15.10.2020.
//

import Foundation
import UIKit

protocol ServiceAddRouterProtocol: class {
    func backAction()
}

class ServiceAddRouter: ServiceAddRouterProtocol {
    weak var viewController: ServiceAddController!
    
    init(viewController: ServiceAddController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}


