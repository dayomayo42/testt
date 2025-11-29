//
//  RecordsSearchRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 06.10.2020.
//

import Foundation
import UIKit

protocol RecordsSearchRouterProtocol: class {
    func backAction()
}

class RecordsSearchRouter: RecordsSearchRouterProtocol {
    weak var viewController: RecordsSearchController!

    init(viewController: RecordsSearchController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}
