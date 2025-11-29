//
//  SettingsRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 03.11.2020.
//

import Foundation
import UIKit

protocol SettingsRouterProtocol: class {
    func backAction()
}

class SettingsRouter: SettingsRouterProtocol {
    weak var viewController: SettingsController!
    
    init(viewController: SettingsController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}


