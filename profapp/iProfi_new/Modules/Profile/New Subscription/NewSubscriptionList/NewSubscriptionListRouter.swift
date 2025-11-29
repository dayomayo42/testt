//
//  NewSubscriptionListRoute.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 18.05.2022.
//

import Foundation
import UIKit

protocol NewSubscriptionListRouterProtocol {
    func backAction()
    func contractOfferAction()
    func privacyPolicyAction()
    func subscribe(pos: Int)
    func backToRootVCAction()
}

class NewSubscriptionListRouter: NewSubscriptionListRouterProtocol {
    var viewController: NewSubscriptionListController!
    var serverService: ServerServiceProtocol = ServerService()
    
    init(viewController: NewSubscriptionListController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
    
    func backToRootVCAction() {
        viewController.navigationController?.popToRootViewController(animated: true)
    }
    
    func subscribe(pos: Int) {
        print("subscribe")
    }
    
    func contractOfferAction() {
        serverService.openUrl(with: "https://profapp.app/doc/offer.pdf")
    }
    
    func privacyPolicyAction() {
        serverService.openUrl(with: "https://profapp.app/doc/policy.pdf")
    }
}



