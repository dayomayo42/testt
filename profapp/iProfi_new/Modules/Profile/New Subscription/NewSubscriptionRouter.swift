//
//  NewSubscriptionRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 21.04.2022.
//

import Foundation
import UIKit

protocol NewSubscriptionRouterProtocol {
    func backAction()
    func openSubList(subObject: Subscription?)
}

class NewSubscriptionRouter: NewSubscriptionRouterProtocol {
    var viewController: NewSubscriptionController!
    
    init(viewController: NewSubscriptionController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
    
    func openSubList(subObject: Subscription?) {
        let vc = viewController.getControllerProfile(controller: .subscriptionList) as! NewSubscriptionListController
        vc.subObject = subObject
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}



