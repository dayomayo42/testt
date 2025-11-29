//
//  RemamberPassRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 01.09.2020.
//

import Foundation
import UIKit


protocol RememberPassRouterProtocol: class {
}

class RememberPassRouter: RememberPassRouterProtocol {
    weak var viewController: RememberPassController!
    
    init(viewController: RememberPassController) {
        self.viewController = viewController
    }
}

