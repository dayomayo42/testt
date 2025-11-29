//
//  AuthRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 28.08.2020.
//

import Foundation
import UIKit


protocol AuthRouterProtocol: class {
    
}

class AuthRouter: AuthRouterProtocol {
    weak var viewController: AuthController!
    
    init(viewController: AuthController) {
        self.viewController = viewController
    }
}

