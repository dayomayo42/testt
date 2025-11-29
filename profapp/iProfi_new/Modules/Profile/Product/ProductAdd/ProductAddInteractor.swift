//
//  ProductDetailInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 12.10.2020.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD

protocol ProductAddInteractorProtocol: class {
    func configureView()
    func checkFields(pos: Int, str: String)
    func addProduct(model: ProductCreateModel)
}

class ProductAddInteractor: ProductAddInteractorProtocol {
    weak var viewController: ProductAddController!
    weak var presenter: ProductAddPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    
    init(viewController: ProductAddController, presenter: ProductAddPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
        let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: viewController.view.frame.size.width, height: 30))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(doneButtonAction))
        doneBtn.tintColor = UIColor(named: "appBlue")
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        
        viewController.categoryLabel.text = viewController.category?.name

        viewController.nameField.inputAccessoryView = toolbar
        viewController.brandField.inputAccessoryView = toolbar
        viewController.descriptionField.inputAccessoryView = toolbar
        viewController.priceField.inputAccessoryView = toolbar
        viewController.addButton.isActive = false
        viewController.priceCurrency.text = Settings.currency
    }
    
    @objc func doneButtonAction() {
        viewController.view.endEditing(true)
    }
    
    func checkFields(pos: Int, str: String) {
        switch pos {
        case 0:
            if str.count > 0 && viewController.priceField.text?.count ?? 0 > 0 {
                viewController.addButton.isActive = true
            } else {
                viewController.addButton.isActive = false
            }
        case 3:
            if viewController.nameField.text?.count ?? 0 > 0 && str.count > 0 {
                viewController.addButton.isActive = true
            } else {
                viewController.addButton.isActive = false
            }
        default:
            if viewController.nameField.text?.count ?? 0 > 0 && viewController.priceField.text?.count ?? 0 > 0 {
                viewController.addButton.isActive = true
            } else {
                viewController.addButton.isActive = false
            }
        }
    }
    
    func addProduct(model: ProductCreateModel) {
        SVProgressHUD.show()
        service.postProduct(model: model).subscribe { (response) in
            SVProgressHUD.dismiss()
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

