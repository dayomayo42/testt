//
//  AddClientRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 25.10.2020.
//

import Foundation
import UIKit

protocol AddClientRouterProtocol: class {
    func backAction()
}

class AddClientRouter: AddClientRouterProtocol {
    weak var viewController: AddClientController!
    
    init(viewController: AddClientController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}


