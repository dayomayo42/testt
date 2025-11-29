//
//  RememberSuccessRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 02.09.2020.
//

import Foundation
import UIKit

protocol RememberSuccessRouterProtocol: class {
    func dismiss()
}

class RememberSuccessRouter: RememberSuccessRouterProtocol {
    weak var viewController: RememberSuccessController!
    
    init(viewController: RememberSuccessController) {
        self.viewController = viewController
    }
    
    func dismiss() {
        self.viewController.navigationController?.popToRootViewController(animated: true)
    }
}

