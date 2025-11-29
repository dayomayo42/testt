//
//  FeedbackPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 27.10.2020.
//

import Foundation
import UIKit

protocol FeedbackPresenterProtocol: class {
    var router: FeedbackRouterProtocol! { get set }
    func configureView()
    func backAction()
    func checkView()
    func sendAction()
}

class FeedbackPresenter: FeedbackPresenterProtocol {
    var router: FeedbackRouterProtocol!
    var interactor: FeedbackInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func checkView() {
        interactor.checkView()
    }
    
    func sendAction() {
        interactor.sendAction()
    }
}

