//
//  ProductDetailInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 13.10.2020.
//

import Foundation
import Moya
import RxSwift
import SVProgressHUD
import UIKit

protocol ProductDetailInteractorProtocol: class {
    func configureView(with product: Product)
    func editMode(edit: Bool, product: Product)
    func sendEdited(product: Product)
    func delete(id: Int)
}

class ProductDetailInteractor: ProductDetailInteractorProtocol {
    weak var viewController: ProductDetailController!
    weak var presenter: ProductDetailPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()

    init(viewController: ProductDetailController, presenter: ProductDetailPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }

    func configureView(with product: Product) {
        let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: viewController.view.frame.size.width, height: 30))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(doneButtonAction))
        doneBtn.tintColor = UIColor(named: "appBlue")
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()

        viewController.brandField.inputAccessoryView = toolbar
        viewController.nameField.inputAccessoryView = toolbar
        viewController.descField.inputAccessoryView = toolbar
        viewController.sumField.inputAccessoryView = toolbar

        viewController.categoryLabel.text = viewController.category?.name
        viewController.brandField.text = product.brand
        viewController.nameField.text = product.name
        viewController.descField.text = product.datumDescription
        viewController.sumField.text = "\(product.price ?? 0)"
        viewController.currencyLabel.text = Settings.currency
    }

    func sendEdited(product: Product) {
        SVProgressHUD.show()
        service.postEditProduct(model: product).subscribe { response in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if !(response.success ?? false) {
                    SVProgressHUD.showError(withStatus: response.message)
                } else {
                    NotificationCenter.default.post(name: NSNotification.Name.ProductsUpdate, object: nil, userInfo: nil)
                }
            }
        } onError: { error in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    private func showDeleteAlert(completion: @escaping () -> ()) {
        let alert = UIAlertController(title: "Удаление продукта", message: "Вы действительно хотите удалить продукт?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Удалить", style: .default, handler: { action in
            completion()
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .default, handler: { action in
        }))
        viewController.present(alert, animated: true)
    }

    func delete(id: Int) {
        
        showDeleteAlert { [weak self] in
            guard let self else { return }
            
            SVProgressHUD.show()
            self.service.postDeleteProduct(id: id).subscribe { response in
                SVProgressHUD.dismiss()
                if self.viewController != nil {
                    if response.success ?? false {
                        NotificationCenter.default.post(name: NSNotification.Name.ProductsUpdate, object: nil, userInfo: nil)
                        self.viewController.navigationController?.popViewController(animated: true)
                    } else {
                        SVProgressHUD.showError(withStatus: response.message)
                    }
                }
            } onError: { error in
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }.disposed(by: self.disposeBag)
        }
    }

    @objc func doneButtonAction() {
        viewController.view.endEditing(true)
    }

    func editMode(edit: Bool, product: Product) {
        if viewController.isEditMode {
            sendEdited(product: product)
        }
        viewController.isEditMode = edit
        if edit {
            viewController.categoryPlate.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            viewController.brandPlate.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            viewController.namePlate.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            viewController.descPlate.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            viewController.sumPlate.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            
            viewController.brandPlate.isUserInteractionEnabled = true
            viewController.namePlate.isUserInteractionEnabled = true
            viewController.descPlate.isUserInteractionEnabled = true
            viewController.sumPlate.isUserInteractionEnabled = true
            viewController.editButton.setTitle("Сохранить", for: .normal)
            viewController.editButton.setImage(UIImage(), for: .normal)
        } else {
            viewController.brandPlate.isUserInteractionEnabled = false
            viewController.namePlate.isUserInteractionEnabled = false
            viewController.descPlate.isUserInteractionEnabled = false
            viewController.sumPlate.isUserInteractionEnabled = false
            
            viewController.editButton.setTitle("", for: .normal)
            viewController.editButton.setImage(#imageLiteral(resourceName: "pen"), for: .normal)
            viewController.categoryPlate.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9882352941, blue: 1, alpha: 1)
            viewController.brandPlate.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9882352941, blue: 1, alpha: 1)
            viewController.namePlate.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9882352941, blue: 1, alpha: 1)
            viewController.descPlate.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9882352941, blue: 1, alpha: 1)
            viewController.sumPlate.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9882352941, blue: 1, alpha: 1)
            viewController.view.endEditing(true)
        }
    }
}
