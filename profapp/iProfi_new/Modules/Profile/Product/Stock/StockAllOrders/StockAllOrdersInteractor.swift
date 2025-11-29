//
//  StockAllOrdersInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 11.11.2020.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD

protocol StockAllOrdersInteractorProtocol: class {
    func configureView()
    func chooseFilter()
    func getOrders()
    func sortTo(type: String)
    func openDetail(model: StockOrder)
}

class StockAllOrdersInteractor: StockAllOrdersInteractorProtocol {
    weak var viewController: StockAllOrdersController!
    weak var presenter: StockAllOrdersPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    
    init(viewController: StockAllOrdersController, presenter: StockAllOrdersPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
        viewController.tableView.contentInset.top = 20
    }
    
    func chooseFilter() {
        let vc = viewController.getControllerProfile(controller: .filtertype) as! FilterTypeAlert
        vc.delegate = viewController
        viewController.present(vc, animated: true)
    }
    
    func sortLiat(list: [StockOrder]) {
        var bufList: [StockOrder] = list

        for i in 0..<bufList.count {
            let obj = bufList[i]
            let debt = (obj.priceOut ?? 0) - (obj.paid ?? 0)
            bufList[i].debt = debt
        }
        self.viewController.orders = bufList
        checkIfPlaceholderNeeded()
        self.viewController.tableView.reloadData()
    }
    
    func checkIfPlaceholderNeeded() {
        if viewController.orders.count != 0 {
            viewController.placeholderView.isHidden = true
        } else {
            viewController.placeholderView.isHidden = false
        }
    }
    
    func getOrders() {
        SVProgressHUD.show()
        service.getStockOrders().subscribe { (response) in
            SVProgressHUD.dismiss()
            
            if self.viewController != nil {
                if response.success ?? false {
                    self.sortLiat(list: response.data ?? [])
                } else {
                    self.checkIfPlaceholderNeeded()
                    SVProgressHUD.showError(withStatus: response.message)
                }
            }
        } onError: { (error) in
            self.checkIfPlaceholderNeeded()
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    func sortTo(type: String) {
        if type == "low" {
            viewController.orders.sort {
                $0.debt ?? 0 < $1.debt ?? 0
            }
        } else if type == "height" {
            viewController.orders.sort {
                $0.debt ?? 0 > $1.debt ?? 0
            }
        }
        
        self.viewController.tableView.reloadData()
    }
    
    func openDetail(model: StockOrder) {
        let vc =  viewController.getControllerProfile(controller: .stockdetail) as! StockAllOrderDetailController
        vc.model = model
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}


