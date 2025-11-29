//
//  StockRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 28.04.2021.
//

import Foundation
import UIKit

protocol StockRouterProtocol: class {
    func backAction()
    func openSubs() 
}

class StockRouter: StockRouterProtocol {
    weak var viewController: StockController!
    
    init(viewController: StockController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
    
    
    func openSubs() {
        if viewController != nil {
            let vc = viewController.getControllerProfile(controller: .subscription)
            viewController.navigationController?.pushViewController(vc, animated: true)
        }
    }
}



