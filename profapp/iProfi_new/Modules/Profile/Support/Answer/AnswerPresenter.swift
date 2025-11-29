//
//  AnswerPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 27.10.2020.
//

import Foundation
import UIKit

protocol AnswerPresenterProtocol: class {
    var router: AnswerRouterProtocol! { get set }
    func configureView()
    func backAction()
    func openDetail(model: AnswerQuest)
    func getQuest()
}

class AnswerPresenter: AnswerPresenterProtocol {
    var router: AnswerRouterProtocol!
    var interactor: AnswerInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func openDetail(model: AnswerQuest) {
        interactor.openDetail(model: model)
    }
    
    func getQuest() {
        interactor.getQuest()
    }
}

