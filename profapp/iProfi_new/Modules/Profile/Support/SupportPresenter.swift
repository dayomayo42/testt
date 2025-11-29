//
//  SupportPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 27.10.2020.
//

import Foundation
import UIKit

protocol SupportPresenterProtocol: class {
    var router: SupportRouterProtocol! { get set }
    func configureView()
    func backAction()
    func openAnswer()
    func openFeedback()
}

class SupportPresenter: SupportPresenterProtocol {
    var router: SupportRouterProtocol!
    var interactor: SupportInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func openAnswer() {
        interactor.openAnswer()
    }
    
    func openFeedback() {
        interactor.openFeedback()
    }
}

