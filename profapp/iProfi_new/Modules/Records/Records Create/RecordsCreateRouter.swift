//
//  RecordsCreateRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 06.10.2020.
//

import Foundation
import UIKit

protocol RecordsCreateRouterProtocol: class {
    func backAction()
    func chooseService()
    func chooseClient()
    func chooseProduct()
    func openDate()
}

class RecordsCreateRouter: RecordsCreateRouterProtocol {
    weak var viewController: RecordsCreateController!

    init(viewController: RecordsCreateController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
    
    func chooseClient() {
        let vc = viewController.getControllerClients(controller: .clients) as! ClientsController
        vc.delegate = viewController
        vc.cache = viewController
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func chooseService() {
        let vc = viewController.getControllerRecord(controller: .recordservices) as! RecordsServiceController
        vc.delegate = viewController
        vc.cache = viewController
        viewController.navigationController?.pushViewController(vc, animated: true)
    }

    func chooseProduct() {
        let vc = viewController.getControllerRecord(controller: .recordsproduct) as! RecordsProductsController
        vc.delegate = viewController
        vc.cache = viewController
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openDate() {
        let vc = viewController.getControllerRecord(controller: .calendarmonth) as! RecordsCalendarMonthController
        
        vc.createDelegate = viewController
        vc.records = viewController.records
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
