//
//  StockProductAddInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 06.11.2020.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD


protocol StockProductAddInteractorProtocol: class {
    func configureView()
    func checkField()
    func chooseSupplier()
    func postProduct()
    func choosePhoto()
}

class StockProductAddInteractor: StockProductAddInteractorProtocol {
    weak var viewController: StockProductAddController!
    weak var presenter: StockProductAddPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    var supplier: Supplier? {
        didSet {
            viewController.supplierLabel.text = supplier?.name
        }
    }
    
    init(viewController: StockProductAddController, presenter: StockProductAddPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
        let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: viewController.view.frame.size.width, height: 30))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(doneButtonAction))
        doneBtn.tintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        
        viewController.nameField.inputAccessoryView = toolbar
        viewController.sellPriceField.inputAccessoryView = toolbar
        viewController.defaultPriceField.inputAccessoryView = toolbar
        viewController.descField.inputAccessoryView = toolbar
        viewController.defaultPriceCurrency.text = Settings.currency
        viewController.sellPriceCurrency.text = Settings.currency
        checkField()
    }
    
    @objc func doneButtonAction() {
        viewController.view.endEditing(true)
    }
    
    func checkField() {
        if viewController.nameField.text?.count ?? 0 > 0 && viewController.supplierLabel.text?.count ?? 0 > 0 && viewController.sellPriceField.text?.count ?? 0 > 0 && viewController.defaultPriceField.text?.count ?? 0 > 0 {
            viewController.addButton.isActive = true
        } else {
            viewController.addButton.isActive = false
        }
    }
    
    func choosePhoto() {
        let alert = UIAlertController(title: "Выберите изображение", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Камера", style: .default, handler: { _ in
            self.openCamera()
        }))

        alert.addAction(UIAlertAction(title: "Галерея", style: .default, handler: { _ in
            self.openGallery()
        }))

        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = viewController
                imagePicker.sourceType = .camera
                imagePicker.allowsEditing = false
                viewController.present(imagePicker, animated: true, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: "Ошибка", message: "У вас нет камеры.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            viewController.present(alert, animated: true, completion: nil)
        }
    }

    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = viewController
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            viewController.present(imagePicker, animated: true, completion: nil)

        } else {
            let alert = UIAlertController(title: "Ошибка", message: "У вас нет доступа к галерее.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    func postProduct() {
        if viewController.photoURL != nil {
            postPhoto()
        } else {
            addProduct(photo: "")
        }
    }
    
    func addProduct(photo: String) {
        SVProgressHUD.show()
        service.postStockProduct(model: StockProductCreateModel(name: viewController.nameField.text ?? "", dealerID: supplier?.id ?? 0, priceIn: viewController.defaultPriceField.text?.toInt() ?? 0, priceOut: viewController.sellPriceField.text?.toInt() ?? 0, stockProductCreateModelDescription: viewController.descField.text ?? "", image: photo)).subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    self.viewController.navigationController?.popViewController(animated: true)
                } else {
                    SVProgressHUD.showError(withStatus: response.message)
                }
            }
        } onError: { (error) in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    func postPhoto() {
        SVProgressHUD.show()
            service.postPhoto(url: viewController.photoURL!).subscribe { (response) in
                if self.viewController != nil {
                    if response.success ?? false {
                        self.addProduct(photo: response.data?.url ?? "")
                    }
                }
            } onError: { (error) in
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }.disposed(by: disposeBag)
    }
    
    func chooseSupplier() {
        let vc = viewController.getControllerProfile(controller: .suppliers) as! SuppliersController
        vc.stockInteractor = self
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}

