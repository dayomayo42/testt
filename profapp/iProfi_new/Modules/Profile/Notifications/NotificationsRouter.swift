//
//  NotificationsRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 02.12.2020.
//

import Foundation
import UIKit

protocol NotificationsRouterProtocol: class {
    func backAction()
}

class NotificationsRouter: NotificationsRouterProtocol {
    weak var viewController: NotificationsController!
    
    init(viewController: NotificationsController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}



