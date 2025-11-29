//
//  SettingsPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 28.10.2020.
//

import Foundation
import UIKit

protocol ShedulePresenterProtocol: class {
    var router: SheduleRouterProtocol! { get set }
    func configureView()
    func configureView(with model: SheduleModel)
    func backAction()
    func openOnline()
    func openWeeks()
    
    func sendData(with model: SheduleModel)
    func getShadule()
}

class ShedulePresenter: ShedulePresenterProtocol {
    var router: SheduleRouterProtocol!
    var interactor: SheduleInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func openOnline() {
        interactor.openOnline()
    }
    
    func openWeeks() {
        interactor.openWeeks()
    }
    
    func configureView(with model: SheduleModel) {
        interactor.configureView(with: model)
    }
    
    func sendData(with model: SheduleModel) {
        interactor.sendData(with: model)
    }
    
    func getShadule() {
        interactor.getShadule()
    }
}

