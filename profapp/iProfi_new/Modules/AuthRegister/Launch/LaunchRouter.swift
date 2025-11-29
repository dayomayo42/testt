//
//  LaunchRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 28.08.2020.
//

import Foundation
import UIKit

protocol LaunchRouterProtocol: class {
    
}

class LaunchRouter: LaunchRouterProtocol {
    weak var viewController: LaunchController!
    
    init(viewController: LaunchController) {
        self.viewController = viewController
    }
}
