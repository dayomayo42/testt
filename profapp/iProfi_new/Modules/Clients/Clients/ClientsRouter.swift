//
//  ClientsRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 01.10.2020.
//

import Foundation
import UIKit

protocol ClientsRouterProtocol: class {
    func backAction()
}

class ClientsRouter: ClientsRouterProtocol {
    weak var viewController: ClientsController!

    init(viewController: ClientsController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}
