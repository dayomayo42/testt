//
//  RegSphereRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 11.09.2020.
//

import Foundation
import UIKit

protocol RegSphereRouterProtocol: class {
    func dismiss()
}

class RegSphereRouter: RegSphereRouterProtocol {
    weak var viewController: RegSphereController!
    
    init(viewController: RegSphereController) {
        self.viewController = viewController
    }
    
    func dismiss() {
        viewController.navigationController?.popViewController(animated: true)
    }
}

