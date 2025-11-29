//
//  SuppliersInteeractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 15.10.2020.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD

protocol SuppliersInteractorProtocol: class {
    func configureView()
    func addAction()
    func detailAction(with model: Supplier)
    func getSuppliers()
    func chooseSupplier(with model: Supplier)
    func search(string: String)
}

class SuppliersInteractor: SuppliersInteractorProtocol {
    weak var viewController: SuppliersController!
    weak var presenter: SuppliersPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    
    init(viewController: SuppliersController, presenter: SuppliersPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
    }
    
    func addAction() {
        let vc = viewController.getControllerProfile(controller: .supplieradd)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func detailAction(with model: Supplier) {
        if viewController.stockInteractor != nil {
            viewController.stockInteractor?.supplier = model
            viewController.navigationController?.popViewController(animated: true)
        } else if viewController.stockDetailInteractor != nil {
            viewController.stockDetailInteractor?.supplier = model
            viewController.navigationController?.popViewController(animated: true)
        } else {
            let vc = viewController.getControllerProfile(controller: .supplierdetail) as! SupplierDetailController
            vc.model = model
            viewController.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func checkIfPlaceholderNeeded() {
        if viewController.suppliers.count != 0 {
            viewController.placeholderView.isHidden = true
        } else {
            viewController.placeholderView.isHidden = false
        }
    }
    
    func getSuppliers() {
        SVProgressHUD.show()
        service.getSuppliers().subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    self.viewController.suppliers = response.data ?? []
                    self.checkIfPlaceholderNeeded()
                    self.viewController.suppliersBuffer = response.data ?? []
                    self.viewController.tableView.reloadData()
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
    
    func chooseSupplier(with model: Supplier) {
        viewController.stockDelegate?.supplier = model
        viewController.navigationController?.popViewController(animated: true)
    }
    
    func search(string: String) {
        self.viewController.suppliers = []
        
        self.viewController.suppliersBuffer.forEach { (product) in
            if product.name?.lowercased().contains(string.lowercased()) ?? false {
                self.viewController.suppliers.append(product)
            }
        }
        self.viewController.tableView.reloadData()
    }
}

