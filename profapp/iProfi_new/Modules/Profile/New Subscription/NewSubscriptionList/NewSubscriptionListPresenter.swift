//
//  NewSubscriptionListPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 18.05.2022.
//

import Foundation
import UIKit

protocol NewSubscriptionListPresenterProtocol {
    var router: NewSubscriptionListRouterProtocol! { get set }
    func configureView()
    func backAction()
    func contractOfferAction()
    func privacyPolicyAction()
    func subscribe(pos: Int)
    func backToRootVCAction()
}

class NewSubscriptionListPresenter: NewSubscriptionListPresenterProtocol {
    
    var router: NewSubscriptionListRouterProtocol!
    var interactor: NewSubscriptionListInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func backToRootVCAction() {
        router.backToRootVCAction()
    }
    
    func subscribe(pos: Int) {
        interactor.subscribe(pos: pos)
    }
    func contractOfferAction() {
        router.contractOfferAction()
    }
    
    func privacyPolicyAction() {
        router.privacyPolicyAction()
    }
}


