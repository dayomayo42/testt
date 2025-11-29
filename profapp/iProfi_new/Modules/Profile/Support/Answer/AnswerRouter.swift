//
//  AnswerRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 27.10.2020.
//

import Foundation
import UIKit

protocol AnswerRouterProtocol: class {
    func backAction()
}

class AnswerRouter: AnswerRouterProtocol {
    weak var viewController: AnswerController!
    
    init(viewController: AnswerController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}


