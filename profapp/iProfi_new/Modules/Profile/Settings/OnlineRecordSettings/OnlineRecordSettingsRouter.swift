//
//  OnlineRecordSettingsRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 01.12.2020.
//

import Foundation
import UIKit

protocol OnlineRecordSettingsRouterProtocol: class {
    func backAction()
}

class OnlineRecordSettingsRouter: OnlineRecordSettingsRouterProtocol {
    weak var viewController: OnlineRecordSettingsController!
    
    init(viewController: OnlineRecordSettingsController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}



