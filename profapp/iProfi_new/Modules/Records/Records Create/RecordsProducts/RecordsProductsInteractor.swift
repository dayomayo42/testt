//
//  RecordsProductsInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 26.10.2020.
//

import Foundation
import Moya
import RxSwift
import SVProgressHUD
import UIKit

protocol RecordsProductsInteractorProtocol: class {
    func configureView()
    func checkCacheProducts()
    func getProduct()
    func chooseProduct()
    func addProduct()
    func search(string: String)
    func chooseNoProduct()
}

class RecordsProductsInteractor: RecordsProductsInteractorProtocol {
    weak var viewController: RecordsProductsController!
    weak var presenter: RecordsProductsPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()

    init(viewController: RecordsProductsController, presenter: RecordsProductsPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }

    func configureView() {
        if viewController.delegate?.model.originalProduct?.count ?? 0 > 0 {
            viewController.product = viewController.delegate?.model.originalProduct ?? []
        }

        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let comletionButton = UIBarButtonItem(title: "Готово", style: UIBarButtonItem.Style.plain, target: self, action: #selector(completionDatePickerAction))
        toolbar.setItems([spaceButton, comletionButton], animated: false)
        toolbar.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

        viewController.searchField.inputAccessoryView = toolbar
    }

    @objc func completionDatePickerAction() {
        viewController.view.endEditing(true)
    }
    
    func checkCacheProducts() {
        guard let vc = viewController else { return }
        if let products = vc.cache?.recordCache.products?.data {
            self.viewController.product = products
            self.viewController.productBuf = products
            if self.viewController.delegate != nil {
                self.fillProductCreate()
            } else {
                self.fillOldProduct()
            }
        } else {
            getProduct()
        }
    }

    func getProduct() {
        SVProgressHUD.show()
        service.getSotedProduct().subscribe { response in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    self.viewController.cache?.recordCache.products = response
                    self.viewController.product = response.data ?? []
                    self.viewController.productBuf = response.data ?? []
                    if self.viewController.delegate != nil {
                        self.fillProductCreate()
                    } else {
                        self.fillOldProduct()
                    }
                } else {
                    SVProgressHUD.showError(withStatus: response.message)
                }
            }
        } onError: { error in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }

    func fillOldProduct() {
        
        for item in viewController.editdelegate?.model?.expandables ?? [] {
            if let catIndex = viewController.productBuf.firstIndex(where: { $0.id == item.expcategoryID }) {
                let objIndex = viewController.productBuf[catIndex].expandables?.firstIndex(where: { $0.id == item.id })
                viewController.productBuf[catIndex].expandables?[objIndex ?? 0].pivot = ProductShort(id: item.pivot?.id, count: item.pivot?.count)
            }
        }
        
        viewController.product = viewController.productBuf
        viewController.tableView.reloadData()
    }

    func fillProductCreate() {
        
        for item in viewController.delegate?.model.product ?? [] {
            if let catIndex = viewController.productBuf.firstIndex(where: { $0.id == item.expcategoryID }) {
                let objIndex = viewController.productBuf[catIndex].expandables?.firstIndex(where: { $0.id == item.id })
                viewController.productBuf[catIndex].expandables?[objIndex ?? 0].pivot = ProductShort(id: item.pivot?.id, count: item.pivot?.count)
            }
        }
        
        viewController.product = viewController.productBuf
        viewController.tableView.reloadData()
    }

    func chooseProduct() {
        var selectedProduct: [Product] = []
        for item in viewController.product {
            for prod in item.expandables ?? [] {
                if prod.pivot?.count ?? 0 > 0 {
                    selectedProduct.append(prod)
                }
            }
        }
        if viewController.delegate != nil {
            viewController.delegate?.model.originalProduct = viewController.product
            viewController.delegate?.model.product = selectedProduct
        } else {
            viewController.editdelegate?.originalProduct = viewController.product
            viewController.editdelegate?.model?.expandables = selectedProduct
        }

        viewController.navigationController?.popViewController(animated: true)
    }

    func addProduct() {
        let vc = viewController.getControllerRecord(controller: .recordsCreateProduct) as! RecordsProductCategoryController
        viewController.navigationController?.pushViewController(vc, animated: true)
    }

    func search(string: String) {
        viewController.product = []
        for item in viewController.productBuf {
            if item.name?.lowercased().contains(string.lowercased()) ?? false {
                viewController.product.append(item)
            } else {
                for itemExp in item.expandables ?? [] {
                    if itemExp.name?.lowercased().contains(string.lowercased()) ?? false {
                        if viewController.product.contains(where: { $0.id == item.id }) {
                            viewController.product[viewController.product.count - 1].expandables?.append(itemExp)
                        } else {
                            viewController.product.append(item)
                            viewController.product[viewController.product.count - 1].expandables = []
                            viewController.product[viewController.product.count - 1].expandables?.append(itemExp)
                        }
                    }
                }
            }
        }

        viewController.tableView.reloadData()
    }

    func chooseNoProduct() {
        let selectedProduct: [Product] = []
        if viewController.delegate != nil {
            viewController.delegate?.model.originalProduct = viewController.product
            viewController.delegate?.model.product = selectedProduct
        } else {
            viewController.editdelegate?.originalProduct = viewController.product
            viewController.editdelegate?.model?.expandables = selectedProduct
        }

        viewController.navigationController?.popViewController(animated: true)
    }
}
