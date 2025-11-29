//
//  ContactListRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 30.11.2020.
//

import Foundation
import UIKit

protocol ContactListRouterProtocol: class {
    func backAction()
}

class ContactListRouter: ContactListRouterProtocol {
    weak var viewController: ContactListController!
    
    init(viewController: ContactListController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}



