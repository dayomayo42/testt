//
//  SpecRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 24.10.2020.
//

import Foundation
import UIKit

protocol SpecRouterProtocol: class {
    func backAction()
    func selectSpec(spec: Spec)
}

class SpecRouter: SpecRouterProtocol {
    weak var viewController: SpecController!
    
    init(viewController: SpecController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
    
    func selectSpec(spec: Spec) {
        if viewController.pos > (viewController.inter?.specs.count ?? 0) - 1 {
            viewController.inter?.specs.append(spec)
        } else {
            viewController.inter?.specs[viewController.pos] = spec
        }
        viewController.navigationController?.popViewController(animated: true)
    }
}


