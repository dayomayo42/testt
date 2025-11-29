//
//  SupplierDetailInteracor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 16.10.2020.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD

protocol SupplierDetailInteractorProtocol: class {
    func configureView()
    func configureView(from model: CountriesModel?)
    func configureView(from model: Supplier)
    func toCountryList()
    func editMode(edit: Bool)
    func share(link: String)
    func deleteSupplier()
}

class SupplierDetailInteractor: SupplierDetailInteractorProtocol {
    weak var viewController: SupplierDetailController!
    var presenter: SupplierDetailPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    
    init(viewController: SupplierDetailController, presenter: SupplierDetailPresenterProtocol) {
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
        viewController.numberField.inputAccessoryView = toolbar
        viewController.mailField.inputAccessoryView = toolbar
        viewController.addressField.inputAccessoryView = toolbar
        viewController.descField.inputAccessoryView = toolbar

        viewController.numberField.setup()
//        viewController.listener.affinityCalculationStrategy = .prefix
//        viewController.listener.affineFormats = [
//            "+7[000][000][00][00]",
//        ]
//
//        viewController.listener.primaryMaskFormat = "+7[000][000][00][00]"
    }
    
    func configureView(from model: Supplier) {
        viewController.nameField.text = model.name
        viewController.numberField.text = model.phone
        viewController.mailField.text = model.email
        viewController.addressField.text = model.address
        viewController.descField.text = model.desc
    }
    
    @objc func doneButtonAction() {
        viewController.view.endEditing(true)
    }
    
    func configureView(from model: CountriesModel?) {

        viewController.numberField.text = ""
//        viewController.listener.primaryMaskFormat = "+\(model?.phoneMask ?? "")[000][000][000][000]"
    }

    func toCountryList() {
        let vc = viewController.getController(controller: .country) as! ChooseCountryController
        vc.authPresenter = presenter
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func editMode(edit: Bool) {
        if viewController.isEditMode {
            sendSupplier()
        }
        viewController.isEditMode = edit
        if edit {
            viewController.namePlate.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            viewController.numberPlate.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            viewController.mailPlate.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            viewController.addressPlate.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            viewController.descPlate.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            viewController.namePlate.isUserInteractionEnabled = true
            viewController.numberPlate.isUserInteractionEnabled = true
            viewController.mailPlate.isUserInteractionEnabled = true
            viewController.addressPlate.isUserInteractionEnabled = true
            viewController.descPlate.isUserInteractionEnabled = true
            viewController.editButton.setTitle("Сохранить", for: .normal)
            viewController.editButton.setImage(UIImage(), for: .normal)
        } else {
            viewController.editButton.setTitle("", for: .normal)
            viewController.editButton.setImage(#imageLiteral(resourceName: "pen"), for: .normal)
            viewController.namePlate.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9882352941, blue: 1, alpha: 1)
            viewController.numberPlate.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9882352941, blue: 1, alpha: 1)
            viewController.mailPlate.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9882352941, blue: 1, alpha: 1)
            viewController.addressPlate.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9882352941, blue: 1, alpha: 1)
            viewController.descPlate.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9882352941, blue: 1, alpha: 1)
            viewController.namePlate.isUserInteractionEnabled = false
            viewController.numberPlate.isUserInteractionEnabled = false
            viewController.mailPlate.isUserInteractionEnabled = false
            viewController.addressPlate.isUserInteractionEnabled = false
            viewController.descPlate.isUserInteractionEnabled = false
            viewController.view.endEditing(true)
        }
    }
    
    func share(link: String) {
        let vc = viewController.getControllerProfile(controller: .sharealert) as! ShareAlert
        vc.link = link
        viewController.present(vc, animated: true)
    }
    
    func deleteSupplier() {
        SVProgressHUD.show()
        service.postDeleteSupplier(id: viewController.model?.id ?? 0).subscribe { (response) in
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
    
    func sendSupplier() {
        SVProgressHUD.show()
        service.postEditSupplier(model: Supplier(id: viewController.model?.id, name: viewController.nameField.text, phone: viewController.numberField.text, email: viewController.mailField.text, address: viewController.addressField.text, desc: viewController.descField.text)).subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                } else {
                    SVProgressHUD.showError(withStatus: response.message)
                }
            }
        } onError: { (error) in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
}

