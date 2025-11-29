//
//  StockBalanceInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 16.12.2020.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD

protocol StockBalanceInteractorProtocol: class {
    func configureView()
    func getProducts()
}

class StockBalanceInteractor: StockBalanceInteractorProtocol {
    weak var viewController: StockBalanceController!
    weak var presenter: StockBalancePresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    
    init(viewController: StockBalanceController, presenter: StockBalancePresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
        viewController.tableView.contentInset.top = 16
        var sum = 0
        
        viewController.products.forEach { (item) in
            sum += (item.priceOut ?? 0) * (item.count ?? 0)
        }
        
        viewController.sumLabel.text = "\(sum) \(Settings.currencyCym ?? "")"
        
    }
    
    func checkIfPlaceholderNeeded() {
        if viewController.products.count != 0 {
            viewController.placeholderView.isHidden = true
        } else {
            viewController.placeholderView.isHidden = false
        }
    }
    
    func getProducts() {
        SVProgressHUD.show()
        service.getStockProduct().subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    self.viewController.products = response.data ?? []
                    self.checkIfPlaceholderNeeded()
                    self.viewController.tableView.reloadData()
                    self.configureView()
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


