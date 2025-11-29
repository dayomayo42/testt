//
//  ProductInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 07.10.2020.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD

protocol ProductInteractorProtocol: class {
    func configureView()
    func openCategory(category: Category)
    func addCategory()
    func getCategories()
}

class ProductInteractor: ProductInteractorProtocol {
    weak var viewController: ProductController!
    weak var presenter: ProductPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    var first = true

    init(viewController: ProductController, presenter: ProductPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }

    func configureView() {
    }
    
    func openCategory(category: Category) {
        let vc = viewController.getControllerProfile(controller: .categorudetail) as! CategoryDetailController
        vc.category = category
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func addCategory() {
        let vc = viewController.getControllerProfile(controller: .categoryadd)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func checkIfPlaceholderNeeded() {
        if viewController.categories.count != 0 {
            viewController.placeholderView.isHidden = true
        } else {
            viewController.placeholderView.isHidden = false
        }
    }
    
    // ["Справочник поставщиков", "Справочник товаров", "Приход товаров", "Расход товаров", "Остаток товаров на складе", "Заказы"]
    
    func getCategories() {
        if first {
            self.viewController.showHUD(show: true)
            first = false
        }
        service.getCategories().subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    self.viewController.categories = response.data ?? []
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
    

}
