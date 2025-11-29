//
//  StockInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 28.04.2021.
//

import Foundation
import UIKit

protocol StockInteractorProtocol: class {
    func configureView()
    func supplierDirectory()
    func productCatalog()
    func productArrival()
    func productConsumption()
    func productRemaining()
    func productOrders()
}

class StockInteractor: StockInteractorProtocol {
    weak var viewController: StockController!
    weak var presenter: StockPresenterProtocol!
    
    init(viewController: StockController, presenter: StockPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
        if (Settings.subType == "account") || (Settings.subType == "premium") {
            self.viewController.tableView.isHidden = false
            self.viewController.subPlate.isHidden = true
        } else {
            self.viewController.tableView.isHidden = true
            self.viewController.subPlate.isHidden = false
        }
    }
    
    func productCatalog() {
        let vc = viewController.getControllerProfile(controller: .productstock)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func productArrival() {
        let vc = viewController.getControllerProfile(controller: .stockarrival)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func productConsumption() {
        let vc = viewController.getControllerProfile(controller: .stockconsuption)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func productRemaining() {
        let vc = viewController.getControllerProfile(controller: .stockbalance)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func productOrders() {
        let vc = viewController.getControllerProfile(controller: .stockorders)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func supplierDirectory() {
        let vc = viewController.getControllerProfile(controller: .suppliers)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}


