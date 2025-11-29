//
//  StockDebtsDetailInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 11.11.2020.
//

import Foundation
import UIKit

protocol StockDebtsDetailInteractorProtocol: class {
    func configureView()
    func sortList()
    func openDetail()
}

class StockDebtsDetailInteractor: StockDebtsDetailInteractorProtocol {
    weak var viewController: StockDebtsDetailController!
    weak var presenter: StockDebtsDetailPresenterProtocol!
    
    init(viewController: StockDebtsDetailController, presenter: StockDebtsDetailPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
        viewController.tableView.contentInset.top = 12
        viewController.nameLabel.text = viewController.model?.name
    }
    
    func sortList() {
//        let newList = viewController.model?.orderList?.filter{$0.debt ?? 0 > 0}
//        viewController.orderList = newList ?? []
        viewController.tableView.reloadData()
    }
    
    func openDetail() {
        let vc = viewController.getControllerProfile(controller: .updatedebt) as! StockUpdateDebtController
        vc.delegate = viewController
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}


