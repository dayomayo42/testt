//
//  WebParthnerRouter.swift
//  iProfi_new
//
//  Created by violy on 23.09.2022.
//

import Foundation

protocol WebParthnerRouterProtocol {
    func backAction()
}

class WebParthnerRouter: WebParthnerRouterProtocol {
    var viewController: WebParthnerController!
    
    init(viewController: WebParthnerController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}
