//
//  RecordDetailRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 27.10.2020.
//

import Foundation
import UIKit

protocol RecordDetailRouterProtocol: class {
    func backAction()
    func repeateRecord()
    func chooseClient()
    func chooseService()
    func chooseProduct()
}

class RecordDetailRouter: RecordDetailRouterProtocol {
    weak var viewController: RecordDetailController!
    
    init(viewController: RecordDetailController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
    
    func repeateRecord() {
        let vc = viewController.getControllerRecord(controller: .createRecord) as! RecordsCreateController
        vc.records = viewController.records
        vc.oldRecord = viewController.model
        vc.repeate = true
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func chooseClient() {
        let vc = viewController.getControllerClients(controller: .clients) as! ClientsController
        vc.editdelegate = viewController
        vc.cache = viewController
        viewController.navigationController?.pushViewController(vc, animated: true)
    }

    func chooseService() {
        let vc = viewController.getControllerRecord(controller: .recordservices) as! RecordsServiceController
        vc.editdelegate = viewController
        vc.cache = viewController
        viewController.navigationController?.pushViewController(vc, animated: true)
    }

    func chooseProduct() {
        let vc = viewController.getControllerRecord(controller: .recordsproduct) as! RecordsProductsController
        vc.editdelegate = viewController
        vc.cache = viewController
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}


