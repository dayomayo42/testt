//
//  SubscribeTrialRouter.swift
//  iProfi_new
//
//  Created by violy on 20.01.2023.
//

import Foundation

protocol SubscribeTrialRouterProtocol {
    func backAction()
    func openSubscriptions()
    func openStartScreen() 
}

class SubscribeTrialRouter: SubscribeTrialRouterProtocol {
    var viewController: SubscribeTrialViewController!
    
    init(viewController: SubscribeTrialViewController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.dismiss(animated: true)
    }
    
    func openStartScreen() {
        let vc = self.viewController.getControllerAppNavigation(controller: .tabbar)
        self.viewController.present(vc, animated: true, completion: nil)
    }
    
    func openSubscriptions() {
        let vc = viewController.getControllerProfile(controller: .subscription) as! NewSubscriptionController
        vc.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
