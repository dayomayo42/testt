//
//  NotificationDetailRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 03.12.2020.
//

import Foundation
import UIKit

protocol NotificationDetailRouterProtocol: class {
    func backAction()
}

class NotificationDetailRouter: NotificationDetailRouterProtocol {
    weak var viewController: NotificationDetailController!
    
    init(viewController: NotificationDetailController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}



