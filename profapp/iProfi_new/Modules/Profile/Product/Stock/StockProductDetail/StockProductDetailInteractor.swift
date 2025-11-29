//
//  StockProductDetailInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 09.11.2020.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD

protocol StockProductDetailInteractorProtocol: class {
    func configureView()
    func checkField()
    func chooseSupplier()
    func postProduct()
    func choosePhoto()
    func editAction(isEdit: Bool)
    func deleteAction()
    func fillView(with model: StockProduct)
}

class StockProductDetailInteractor: StockProductDetailInteractorProtocol {
    weak var viewController: StockProductDetailController!
    weak var presenter: StockProductDetailPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    var supplier: Supplier? {
        didSet {
            viewController.model?.dealer = supplier
            viewController.supplierLabel.text = supplier?.name
        }
    }
    
    init(viewController: StockProductDetailController, presenter: StockProductDetailPresenterProtocol) {
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
        supplier = viewController.model?.dealer
        
        viewController.defaultPriceCurrency.text = Settings.currency
        viewController.sellPriceCurrency.text = Settings.currency
    }
    
    func fillView(with model: StockProduct) {
        viewController.nameField.text = model.name
        viewController.descField.text = model.productDescription
        viewController.supplierLabel.text = model.dealer?.name
        viewController.defaultPriceField.text = "\(model.priceIn ?? 0)"
        viewController.sellPriceField.text = "\(model.priceOut ?? 0)"
        if model.image != "" {
            viewController.photoView.af_setImage(withURL: URL(string: model.image!)!)
        }
    }
    
    @objc func doneButtonAction() {
        viewController.view.endEditing(true)
    }
    
    func checkField() {
   
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
            postEditModel(photo: "")
        }
    }
    
    func postEditModel(photo: String) {
        SVProgressHUD.show()
        let mdl = viewController.model
        service.editStockProduct(model: StockProduct(id: mdl?.id, dealerID: supplier?.id ?? 0, dealer: supplier, image: photo, name: viewController.nameField.text, priceIn: viewController.defaultPriceField.text?.toInt(), priceOut: viewController.sellPriceField.text?.toInt(), productDescription: viewController.descField.text)).subscribe { (response) in
            SVProgressHUD.dismiss()
        } onError: { (error) in
            
        }.disposed(by: disposeBag)
    }
    
    func postPhoto() {
        SVProgressHUD.show()
            service.postPhoto(url: viewController.photoURL!).subscribe { (response) in
                if self.viewController != nil {
                    if response.success ?? false {
                        self.postEditModel(photo: response.data?.url ?? "")
                    }
                }
            } onError: { (error) in
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }.disposed(by: disposeBag)
    }
    
    func chooseSupplier() {
        let vc = viewController.getControllerProfile(controller: .suppliers) as! SuppliersController
        vc.stockDetailInteractor = self
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func editAction(isEdit: Bool) {
        if viewController.isEditMode {
//            sendEdited(product: product)
            if viewController.photoURL != nil {
                postPhoto()
            } else {
                postEditModel(photo: viewController.model?.image ?? "")
            }
        }
        viewController.isEditMode = isEdit
        if isEdit {
            viewController.sellPricePlate.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            viewController.defaultPricePlate.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            viewController.namePlate.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            viewController.descPlate.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            viewController.supplierPlate.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            viewController.photoPlate.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            viewController.photoPlate.isUserInteractionEnabled = true
            
            viewController.sellPricePlate.isUserInteractionEnabled = true
            viewController.namePlate.isUserInteractionEnabled = true
            viewController.descPlate.isUserInteractionEnabled = true
            viewController.defaultPricePlate.isUserInteractionEnabled = true
            viewController.supplierPlate.isUserInteractionEnabled = true
            viewController.editButton.setTitle("Сохранить", for: .normal)
            viewController.editButton.setImage(UIImage(), for: .normal)
        } else {
            viewController.sellPricePlate.isUserInteractionEnabled = false
            viewController.namePlate.isUserInteractionEnabled = false
            viewController.descPlate.isUserInteractionEnabled = false
            viewController.defaultPricePlate.isUserInteractionEnabled = false
            viewController.supplierPlate.isUserInteractionEnabled = false
            
            viewController.photoPlate.isUserInteractionEnabled = false
            viewController.photoPlate.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9882352941, blue: 1, alpha: 1)
            
            viewController.editButton.setTitle("", for: .normal)
            viewController.editButton.setImage(#imageLiteral(resourceName: "pen"), for: .normal)
            viewController.sellPricePlate.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9882352941, blue: 1, alpha: 1)
            viewController.defaultPricePlate.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9882352941, blue: 1, alpha: 1)
            viewController.namePlate.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9882352941, blue: 1, alpha: 1)
            viewController.descPlate.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9882352941, blue: 1, alpha: 1)
            viewController.supplierPlate.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9882352941, blue: 1, alpha: 1)
            viewController.view.endEditing(true)
        }
    }
    
    func deleteAction() {
        SVProgressHUD.show()
        service.deleteStockProduct(id: viewController.model?.id ?? 0).subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil{
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
}



