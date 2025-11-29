//
//  ChooseCountryRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 31.08.2020.
//

import Foundation
import UIKit


protocol ChooseCountryRouterProtocol: class {
    func dismiss()
}

class ChooseCountryRouter: ChooseCountryRouterProtocol {
    weak var viewController: ChooseCountryController!
    
    init(viewController: ChooseCountryController) {
        self.viewController = viewController
    }
    
    func dismiss() {
        self.viewController.navigationController?.popViewController(animated: true)
    }
}

