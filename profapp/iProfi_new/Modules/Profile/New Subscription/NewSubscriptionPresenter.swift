//
//  NewSubscriptionPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 21.04.2022.
//

import Foundation
import UIKit

protocol NewSubscriptionPresenterProtocol {
    var router: NewSubscriptionRouterProtocol! { get set }
    func configureView()
    func backAction()
    func openSubList(subObject: Subscription?)
}

class NewSubscriptionPresenter: NewSubscriptionPresenterProtocol {
    var router: NewSubscriptionRouterProtocol!
    var interactor: NewSubscriptionInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func openSubList(subObject: Subscription?) {
        router.openSubList(subObject: subObject)
    }
}


