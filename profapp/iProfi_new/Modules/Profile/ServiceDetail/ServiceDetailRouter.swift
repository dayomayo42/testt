//
//  ServiceDetailouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 15.10.2020.
//

import Foundation
import UIKit

protocol ServiceDetailRouterProtocol: class {
    func backAction()
}

class ServiceDetailRouter: ServiceDetailRouterProtocol {
    weak var viewController: ServiceDetailController!
    
    init(viewController: ServiceDetailController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}


