//
//  UserNotificationsRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 31.08.2021.
//

import Foundation
import UIKit

protocol UserNotificationsRouterProtocol {
    func backAction()
    func openSubs()
    func openSettings()
}

class UserNotificationsRouter: UserNotificationsRouterProtocol {
    var viewController: UserNotificationsController!
    
    init(viewController: UserNotificationsController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
    
    func openSubs() {
        if viewController != nil {
            let vc = viewController.getControllerProfile(controller: .subscription)
            viewController.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func openSettings() {
        let vc = viewController.getControllerProfile(controller: .notificationsettings)
        vc.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}



