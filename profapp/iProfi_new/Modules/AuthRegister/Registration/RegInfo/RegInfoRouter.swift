//
//  RegInoRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 09.09.2020.
//

import Foundation
import UIKit

protocol RegInfoRouterProtocol: class {
}

class RegInfoRouter: RegInfoRouterProtocol {
    weak var viewController: RegInfoController!
    
    init(viewController: RegInfoController) {
        self.viewController = viewController
    }
}

