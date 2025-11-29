//
//  OnlineRecordRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 29.10.2020.
//

import Foundation
import UIKit

protocol OnlineRecordRouterProtocol: class {
    func backAction()
}

class OnlineRecordRouter: OnlineRecordRouterProtocol {
    weak var viewController: OnlineRecordController!
    
    init(viewController: OnlineRecordController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}


