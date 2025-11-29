//
//  RecordsServiceRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 26.10.2020.
//

import Foundation
import UIKit

protocol RecordsServiceRouterProtocol: class {
    func backAction()
}

class RecordsServiceRouter: RecordsServiceRouterProtocol {
    weak var viewController: RecordsServiceController!
    
    init(viewController: RecordsServiceController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}


