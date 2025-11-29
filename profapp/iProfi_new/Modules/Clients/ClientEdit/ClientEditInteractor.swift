//
//  ClientEditInteract.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 07.10.2020.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD

protocol ClientEditInteractorProtocol: class {
    func configureView()
    func configureView(with model: Client)
    func toCountryList()
    func configureView(with model: CountriesModel?)
    func deleteUser(with id: Int)
    func editUser(with model: Client)
    func checkFields() -> Bool
}

class ClientEditInteractor: ClientEditInteractorProtocol {
    
    weak var viewController: ClientEditController!
    var presenter: ClientEditPresenterProtocol!
    let dateFormatter = DateFormatter()
    let toolbar = UIToolbar()
    var beginTextField: UITextField?
    var pickerView = UIPickerView()
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()

    init(viewController: ClientEditController, presenter: ClientEditPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }

    func configureView() {
        viewController.saveButton.isActive = true

        toolbar.sizeToFit()

        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let comletionButton = UIBarButtonItem(title: "Готово", style: UIBarButtonItem.Style.plain, target: self, action: #selector(completionDatePickerAction(_:)))
        toolbar.setItems([spaceButton, comletionButton], animated: false)
        toolbar.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

        let datePicker = UIDatePicker()
        datePicker.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        datePicker.alpha = 0.85
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date().getCurrentGmtDate()
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.sizeToFit()
        }
        datePicker.addTarget(self, action: #selector(datePickerAction(_:)), for: .valueChanged)

        pickerView.dataSource = viewController
        pickerView.delegate = viewController

        viewController.surnameField.inputAccessoryView = toolbar
        viewController.nameField.inputAccessoryView = toolbar
        viewController.patronymicField.inputAccessoryView = toolbar
        viewController.phoneNumberField.inputAccessoryView = toolbar
        viewController.mailField.inputAccessoryView = toolbar
        viewController.birthField.inputAccessoryView = toolbar
        viewController.birthField.inputView = datePicker
        viewController.sexField.inputAccessoryView = toolbar
        viewController.sexField.inputView = pickerView
        viewController.noteField.inputAccessoryView = toolbar

        viewController.phoneNumberField.setup()
    }
    
    func configureView(with model: Client) {
        viewController.surnameField.text = model.lastname
        viewController.nameField.text = model.name
        viewController.patronymicField.text = model.midname
        viewController.phoneNumberField.text = model.phone
        viewController.mailField.text = model.email
        viewController.birthField.text = model.birth
        viewController.sexField.text = model.gender
        viewController.noteField.text = model.note
    }

    func configureView(with model: CountriesModel?) {
        viewController.phoneNumberField.text = ""
//        viewController.listener.primaryMaskFormat = "+\(model?.phoneMask ?? "")[000][000][000][000]"
    }

    func toCountryList() {
        let vc = viewController.getController(controller: .country) as! ChooseCountryController
        vc.authPresenter = presenter
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func checkFields() -> Bool {
        guard let vc = viewController else { return false }
        
        if vc.nameField.text?.withoutSpaces().count ?? 0 < 1 {
            return false
        }
        
        if !(vc.phoneNumberField.isValidNumber) {
            return false
        }
        
        return true
    }

    @objc func datePickerAction(_ picker: UIDatePicker) {
        dateFormatter.dateFormat = "dd.MM.yyyy"
        viewController.birthField.text = dateFormatter.string(from: picker.date)
    }

    @objc func completionDatePickerAction(_ sender: UIButton) {
        beginTextField = nil
        viewController.view.endEditing(true)
        viewController.scrollView.contentSize.height = 840
    }
    
    func deleteUser(with id: Int) {
        service.postDeleteClient(id).subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    NotificationCenter.default.post(name: NSNotification.Name.ClientsUpdate, object: nil, userInfo: nil)
                    self.viewController.navigationController?.popToRootViewController(animated: true)
                } else {
                    SVProgressHUD.showError(withStatus: response.message)
                }
            }
        } onError: { (error) in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    func editUser(with model: Client) {
        SVProgressHUD.show()
        service.postEditClient(model: model).subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    NotificationCenter.default.post(name: NSNotification.Name.ClientsUpdate, object: nil, userInfo: nil)
                    self.viewController.navigationController?.popToRootViewController(animated: true)
                } else {
                    SVProgressHUD.showError(withStatus: response.message)
                }
            }
        } onError: { (error) in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
}
