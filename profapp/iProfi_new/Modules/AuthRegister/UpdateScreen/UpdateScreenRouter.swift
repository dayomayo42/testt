//
//  UpdateScreenRouter.swift
//  iProfi_new
//
//  Created by violy on 19.01.2023.
//

import Foundation
import UIKit

protocol UpdateScreenRouterProtocol {
    func backAction()
    func openItunes()
}

class Router: UpdateScreenRouterProtocol {
    var viewController: UpdateScreenViewController!
    
    init(viewController: UpdateScreenViewController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.dismiss(animated: true)
    }
    
    func openItunes() {
        if let url = URL(string: "itms-apps://itunes.apple.com/app/id1553889063") {
            UIApplication.shared.open(url)
        }
    }
}
