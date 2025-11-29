//
//  ServiceDetailPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 15.10.2020.
//

import Foundation
import UIKit

protocol ServiceDetailPresenterProtocol: class {
    var router: ServiceDetailRouterProtocol! { get set }
    func configureView()
    func backAction()
    func editMode(edit: Bool)
    func deleteAction(id: Int)
}

class ServiceDetailPresenter: ServiceDetailPresenterProtocol {
    var router: ServiceDetailRouterProtocol!
    var interactor: ServiceDetailInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func editMode(edit: Bool) {
        interactor.editMode(edit: edit)
    }
    
    func deleteAction(id: Int) {
        interactor.deleteAction(id: id)
    }
}

