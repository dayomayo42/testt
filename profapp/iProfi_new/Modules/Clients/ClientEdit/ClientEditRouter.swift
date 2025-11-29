//
//  ClientEditRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 07.10.2020.
//

import Foundation
import UIKit

protocol ClientEditRouterProtocol: class {
    func backAction()
}

class ClientEditRouter: ClientEditRouterProtocol {
    weak var viewController: ClientEditController!

    init(viewController: ClientEditController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}
