//
//  NotificationSettingsRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 09.12.2020.
//

import Foundation
import UIKit

protocol NotificationSettingsRouterProtocol: class {
    func backAction()
}

class NotificationSettingsRouter: NotificationSettingsRouterProtocol {
    weak var viewController: NotificationSettingsController!
    
    init(viewController: NotificationSettingsController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}



