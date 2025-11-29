//
//  SupplierAddInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 15.10.2020.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD

protocol SupplierAddInteractorProtocol: class {
    func configureView()
    func configureView(from model: CountriesModel?)
    func toCountryList()
    func createAction()
}

class SupplierAddInteractor: SupplierAddInteractorProtocol {
    weak var viewController: SupplierAddController!
    var presenter: SupplierAddPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    
    init(viewController: SupplierAddController, presenter: SupplierAddPresenterProtocol) {
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
    
    func createAction() {
        SVProgressHUD.show()
        service.postCreateSupplier(model: CreateSupplierModel(name: viewController.nameField.text, phone: viewController.numberField.text, email: viewController.mailField.text, address: viewController.addressField.text, createSupplierModelDescription: viewController.descField.text)).subscribe { (response) in
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
}

