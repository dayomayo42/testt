//
//  FeedbackRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 27.10.2020.
//

import Foundation
import UIKit

protocol FeedbackRouterProtocol: class {
    func backAction()
}

class FeedbackRouter: FeedbackRouterProtocol {
    weak var viewController: FeedbackController!
    
    init(viewController: FeedbackController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}


