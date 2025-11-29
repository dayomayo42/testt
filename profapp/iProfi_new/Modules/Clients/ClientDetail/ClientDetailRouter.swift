//
//  ClientDetailRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 06.10.2020.
//

import Foundation
import UIKit

protocol ClientDetailRouterProtocol: class {
    func backAction()
}

class ClientDetailRouter: ClientDetailRouterProtocol {
    weak var viewController: ClientDetailController!

    init(viewController: ClientDetailController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}
