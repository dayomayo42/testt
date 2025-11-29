//
//  StockDebtsInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 11.11.2020.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD

struct DebtsUser {
    var name: String?
    var debt: Int?
    var orders: [Int]?
    var date: String?
    var orderList: [Debconsumption]?
}

protocol StockDebtsInteractorProtocol: class {
    func configureView()
    func openDetail(with model: DebtsUser)
    func getDebtors()
}

class StockDebtsInteractor: StockDebtsInteractorProtocol {
    weak var viewController: StockDebtsController!
    weak var presenter: StockDebtsPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    
    init(viewController: StockDebtsController, presenter: StockDebtsPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
        viewController.tableView.contentInset.top = 20
    }
    
    func openDetail(with model: DebtsUser) {
        let vc = viewController.getControllerProfile(controller: .debtsdetail) as! StockDebtsDetailController
        vc.model = model
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func sortList(list: [Client]) {
        var bufList: [DebtsUser] = []
        
        for item in list {
            var debtSum = 0
            var ordersNums: [Int] = []
        
            for order in item.debconsumptions ?? [] {
                let debt = (order.priceOut ?? 0) - (order.paid ?? 0)
                debtSum +=  debt
                ordersNums.append(order.id ?? 0)
            }
            
            bufList.append(DebtsUser(name: "\(item.lastname ?? "") \(item.name ?? "") \(item.midname ?? "")", debt: debtSum, orders: ordersNums, date: item.debconsumptions?.last?.dateOut?.convertDate(to: 6), orderList: item.debconsumptions))
        }

        self.viewController.debtors = bufList
        checkIfPlaceholderNeeded()
        self.viewController.tableView.reloadData()
    }
    
    func checkIfPlaceholderNeeded() {
        if viewController.debtors.count != 0 {
            viewController.placeholderView.isHidden = true
        } else {
            viewController.placeholderView.isHidden = false
        }
    }
    
    func getDebtors() {
        SVProgressHUD.show()
        service.getDebtors().subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                 //   self.viewController.clients = response.data ?? []
                    self.sortList(list: response.data ?? [])
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
}



