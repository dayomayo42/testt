//
//  RecordsCalendarRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 16.11.2020.
//

import Foundation
import UIKit

protocol RecordsCalendarRouterProtocol: class {
    func backAction()
    func goToShitfSettings()
}

class RecordsCalendarRouter: RecordsCalendarRouterProtocol {
    weak var viewController: RecordsCalendarController!
    
    init(viewController: RecordsCalendarController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
    
    func goToShitfSettings() {
        let vc = viewController.getControllerProfile(controller: .shedule) as! SheduleController
        vc.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}



