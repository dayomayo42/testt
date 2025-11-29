//
//  RecordsCalendarWeekRouter.swift
//  iProfi_new
//
//  Created by violy on 12.05.2023.
//

import Foundation

protocol RecordsCalendarWeekRouterProtocol {
    func backAction()
}

class RecordsCalendarWeekRouter: RecordsCalendarWeekRouterProtocol {
    var viewController: RecordsCalendarWeekViewController!
    
    init(viewController: RecordsCalendarWeekViewController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}
