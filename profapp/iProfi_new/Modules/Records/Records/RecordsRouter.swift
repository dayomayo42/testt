//
//  RecordsRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 01.10.2020.
//

import Foundation
import UIKit

protocol RecordsRouterProtocol: class {
    func openSubExpiredView()
}

class RecordsRouter: RecordsRouterProtocol {
    weak var viewController: RecordsController!

    init(viewController: RecordsController) {
        self.viewController = viewController
    }
    
    func openSubExpiredView() {
        let vc = viewController.getController(controller: .subTrial) as! SubscribeTrialViewController
        vc.subState = .expired
        viewController.present(NavigationController(rootViewController: vc), animated: true, completion: nil)
    }
}
