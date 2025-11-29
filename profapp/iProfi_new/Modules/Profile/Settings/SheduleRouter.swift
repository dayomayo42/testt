//
//  SettingsRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 28.10.2020.
//

import Foundation
import UIKit

protocol SheduleRouterProtocol: class {
    func backAction()
}

class SheduleRouter: SheduleRouterProtocol {
    weak var viewController: SheduleController!
    
    init(viewController: SheduleController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}


