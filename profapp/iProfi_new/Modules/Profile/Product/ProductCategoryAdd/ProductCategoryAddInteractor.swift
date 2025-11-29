//
//  ProductCategoryAddInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 08.10.2020.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD

protocol ProductCategoryAddInteractorProtocol: class {
    func configureView()
    func addAction()
}

class ProductCategoryAddInteractor: ProductCategoryAddInteractorProtocol {
    weak var viewController: ProductCategoryAddController!
    weak var presenter: ProductCategoryAddPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()

    init(viewController: ProductCategoryAddController, presenter: ProductCategoryAddPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }

    func configureView() {
        viewController.addButton.isActive = false
    }
    
    func addAction() {
        viewController.view.endEditing(true)
        service.postCategories(name: viewController.categoryField.text ?? "").subscribe { (response) in
            if self.viewController != nil {
                if response.success ?? false {
                    NotificationCenter.default.post(name: NSNotification.Name.ProductsUpdate, object: nil, userInfo: nil)
                    self.viewController.navigationController?.popViewController(animated: true)
                } else {
                    SVProgressHUD.showError(withStatus: response.message)
                }
            }
        } onError: { (error) in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)

    }
}
