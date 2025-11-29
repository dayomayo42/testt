//
//  ContactListPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 30.11.2020.
//

import Foundation
import UIKit

protocol ContactListPresenterProtocol: class {
    var router: ContactListRouterProtocol! { get set }
    func configureView()
    func backAction()
    func selectAction()
    func addMultipleContacts(selectedContacts: [PhoneContact])
}

class ContactListPresenter: ContactListPresenterProtocol {
    var router: ContactListRouterProtocol!
    var interactor: ContactListInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func selectAction() {
        interactor.selectAction()
    }
    
    func addMultipleContacts(selectedContacts: [PhoneContact] ) {
        interactor.addMultipleContacts(selectedContacts: selectedContacts)
    }
}


