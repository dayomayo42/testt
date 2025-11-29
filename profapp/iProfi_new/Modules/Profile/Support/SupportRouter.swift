//
//  SupportRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 27.10.2020.
//

import Foundation
import UIKit

protocol SupportRouterProtocol: class {
    func backAction()
}

class SupportRouter: SupportRouterProtocol {
    weak var viewController: SupportController!
    
    init(viewController: SupportController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}


