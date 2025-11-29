//
//  RecordTimeRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 05.11.2020.
//

import Foundation
import UIKit

protocol RecordTimeRouterProtocol: class {
    func backAction()
}

class RecordTimeRouter: RecordTimeRouterProtocol {
    weak var viewController: RecordTimeController!
    
    init(viewController: RecordTimeController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}


