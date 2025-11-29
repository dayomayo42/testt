//
//  StockProdutsInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 06.11.2020.
//

import Foundation
import Moya
import RxSwift
import SVProgressHUD
import UIKit

protocol StockProdutsInteractorProtocol: class {
    func configureView()
    func getProducts()
    func addProduct()
    func openDetail(model: StockProduct)
    func chooseProduct(model: StockProduct)
    func search(string: String)
}

class StockProdutsInteractor: StockProdutsInteractorProtocol {
    weak var viewController: StockProdutsController!
    weak var presenter: StockProdutsPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()

    init(viewController: StockProdutsController, presenter: StockProdutsPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }

    func configureView() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let comletionButton = UIBarButtonItem(title: "Готово", style: UIBarButtonItem.Style.plain, target: self, action: #selector(completionDatePickerAction))
        toolbar.setItems([spaceButton, comletionButton], animated: false)
        toolbar.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        viewController.searchField.inputAccessoryView = toolbar
    }
    
    @objc func completionDatePickerAction() {
        self.viewController.view.endEditing(true)
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
        service.getStockProduct().subscribe { response in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    self.viewController.link = response.link ?? ""
                    self.viewController.products = response.data ?? []
                    self.viewController.productsBuffer = response.data ?? []
                    self.checkIfPlaceholderNeeded()
                    if self.viewController.stockDelegate != nil {
                        if self.viewController.stockDelegate?.supplier != nil {
                            self.viewController.products = self.viewController.products.filter({ $0.dealer?.id == self.viewController.stockDelegate?.supplier?.id })
                            self.viewController.productsBuffer = self.viewController.products.filter({ $0.dealer?.id == self.viewController.stockDelegate?.supplier?.id })
                        }
                    }
                    self.viewController.tableView.reloadData()
                } else {
                    self.checkIfPlaceholderNeeded()
                    SVProgressHUD.showError(withStatus: response.message)
                }
            }
        } onError: { error in
            self.checkIfPlaceholderNeeded() 
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }

    func addProduct() {
        let vc = viewController.getControllerProfile(controller: .productstockadd)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }

    func openDetail(model: StockProduct) {
        let vc = viewController.getControllerProfile(controller: .productstockdetail) as! StockProductDetailController
        vc.model = model
        viewController.navigationController?.pushViewController(vc, animated: true)
    }

    func chooseProduct(model: StockProduct) {
        viewController.stockDelegate?.product = model
        viewController.stockDelegate?.supplier = model.dealer
        viewController.navigationController?.popViewController(animated: true)
    }
    
    func search(string: String) {
        self.viewController.products = []
        
        self.viewController.productsBuffer.forEach { (product) in
            if product.name?.lowercased().contains(string.lowercased()) ?? false {
                self.viewController.products.append(product)
            }
        }
        self.viewController.tableView.reloadData()
    }
}
