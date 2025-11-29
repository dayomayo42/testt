//
//  RegPassRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 03.09.2020.
//

import Foundation
import UIKit

protocol RegPassRouterProtocol: class {
    func makeCall()
}

class RegPassRouter: RegPassRouterProtocol {
    weak var viewController: RegPassController!
    
    init(viewController: RegPassController) {
        self.viewController = viewController
    }
    
    func makeCall() {
        guard var phone = viewController.callModel?.confirmNumber  else { return }
        
        if phone.first != "+" {
            phone = "+\(phone)"
        }
        
        var components = URLComponents()
        components.scheme = "tel"
        components.path = phone.withoutSpaces()
        
        if let url = components.url, UIApplication.shared.canOpenURL(url) {
            print(url)
            UIApplication.shared.open(url)
        }
    }
}

