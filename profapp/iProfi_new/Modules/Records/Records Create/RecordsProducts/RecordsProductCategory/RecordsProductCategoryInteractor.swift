//
//  RecordsProductCategoryInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 18.01.2021.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD

protocol RecordsProductCategoryInteractorProtocol: class {
    func configureView()
    
    func openCategory(category: Category)
    func addCategory()
    func getCategories()
}

class RecordsProductCategoryInteractor: RecordsProductCategoryInteractorProtocol {
    weak var viewController: RecordsProductCategoryController!
    weak var presenter: RecordsProductCategoryPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    
    init(viewController: RecordsProductCategoryController, presenter: RecordsProductCategoryPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
    }
    
    func checkIfPlaceholderNeeded() {
        if viewController.categories.count != 0 {
            viewController.placeholderView.isHidden = true
        } else {
            viewController.placeholderView.isHidden = false
        }
    }
    
    func getCategories() {
        SVProgressHUD.show()
        service.getCategories().subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    self.viewController.categories = response.data ?? []
                    self.checkIfPlaceholderNeeded()
                    self.viewController.tableView.reloadData()
                } else {
                    SVProgressHUD.showError(withStatus: response.message)
                    self.checkIfPlaceholderNeeded()
                }
            }
        } onError: { (error) in
            self.checkIfPlaceholderNeeded()
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)

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
}


