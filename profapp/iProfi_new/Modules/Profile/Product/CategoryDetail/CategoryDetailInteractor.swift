//
//  CatgoryDetailInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 12.10.2020.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD

protocol CategoryDetailInteractorProtocol: class {
    func configureView()
    func addProduct(category: Category)
    func openDetail(with product: Product)
    func getProduct(category id: Int)
    func deleteCategory(category id: Int)
}

class CategoryDetailInteractor: CategoryDetailInteractorProtocol {
    weak var viewController: CategoryDetailController!
    weak var presenter: CategoryDetailPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    var first = true

    init(viewController: CategoryDetailController, presenter: CategoryDetailPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }

    func configureView() {
        viewController.titleView.text = viewController.category?.name
    }
    
    func addProduct(category: Category) {
        let vc = viewController.getControllerProfile(controller: .productadd) as! ProductAddController
        vc.category = category
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openDetail(with product: Product) {
        let vc = viewController.getControllerProfile(controller: .productdetail) as! ProductDetailController
        vc.category = viewController.category
        vc.product = product
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func checkIfPlaceholderNeeded() {
        if viewController.products.count != 0 {
            viewController.placeholderView.isHidden = true
        } else {
            viewController.placeholderView.isHidden = false
        }
    }
    
    func getProduct(category id: Int) {
        if first {
            self.viewController.showHUD(show: true)
            first = false
        }
        service.getProducts(id: id).subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    self.viewController.products = response.data ?? []
                    self.checkIfPlaceholderNeeded()
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
    
    
    private func showDeleteAlert(completion: @escaping () -> ()) {
        let alert = UIAlertController(title: "Удаление категории", message: "Вы действительно хотите удалить категорию?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Удалить", style: .default, handler: { action in
            completion()
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .default, handler: { action in
        }))
        viewController.present(alert, animated: true)
    }
    
    func deleteCategory(category id: Int) {
        self.showDeleteAlert { [weak self] in
            guard let self else { return }
            self.viewController.showHUD(show: true)
            self.service.postDeleteCategory(id: id).subscribe { response in
                SVProgressHUD.dismiss()
                if self.viewController != nil {
                    if response.success ?? false {
                        NotificationCenter.default.post(name: NSNotification.Name.ProductsUpdate, object: nil, userInfo: nil)
                        self.viewController.navigationController?.popViewController(animated: true)
                    }
                }
            } onError: { error in
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }.disposed(by: self.disposeBag)
        }
    }
}
