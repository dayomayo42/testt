//
//  RegPhoneRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 02.09.2020.
//

import Foundation
import UIKit


protocol RegPhoneRouterProtocol: class {
}

class RegPhoneRouter: RegPhoneRouterProtocol {
    weak var viewController: RegPhoneController!
    
    init(viewController: RegPhoneController) {
        self.viewController = viewController
    }
}

