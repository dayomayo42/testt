//
//  AddClientInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 25.10.2020.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD

protocol AddClientInteractorProtocol: class {
    func configureView()
    func toCountryList()
    func configureView(with model: CountriesModel?)
    func checkField()
    func postClient(model: CreateClientModel)
    func choosePhoto()
}

class AddClientInteractor: AddClientInteractorProtocol {
    weak var viewController: AddClientController!
    var presenter: AddClientPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    let dateFormatter = DateFormatter()
    let toolbar = UIToolbar()
    var beginTextField: UITextField?
    var pickerView = UIPickerView()

    init(viewController: AddClientController, presenter: AddClientPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }

    func configureView() {
        viewController.saveButton.isActive = false

        toolbar.sizeToFit()

        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let comletionButton = UIBarButtonItem(title: "Готово", style: UIBarButtonItem.Style.plain, target: self, action: #selector(completionDatePickerAction(_:)))
        toolbar.setItems([spaceButton, comletionButton], animated: false)
        toolbar.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        viewController.surnameField.inputAccessoryView = toolbar

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
        
        if viewController.delegate != nil {
            viewController.surnameField.text = viewController.delegate?.contact?.lastName
            viewController.nameField.text = viewController.delegate?.contact?.firstName
            viewController.phoneNumberField.text = viewController.delegate?.contact?.telephone
            checkField()
        }
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

    @objc func datePickerAction(_ picker: UIDatePicker) {
        dateFormatter.dateFormat = "dd.MM.yyyy"
        viewController.birthField.text = dateFormatter.string(from: picker.date)
    }

    @objc func completionDatePickerAction(_ sender: UIButton) {
        beginTextField = nil
        viewController.view.endEditing(true)
    }
    
    func checkField() {
        if viewController.nameField.text?.count ?? 0 > 1 &&  viewController.phoneNumberField.text?.count ?? 0 > 7 {
            viewController.saveButton.isActive = true
        } else {
            viewController.saveButton.isActive = false
        }
    }
    
    func postClient(model: CreateClientModel) {
        SVProgressHUD.show()
        if viewController.photoURL != nil {
            service.postPhoto(url: viewController.photoURL!).subscribe { (response) in
                if self.viewController != nil {
                    if response.success ?? false {
                        var photmodel = model
                        photmodel.image = response.data?.url
                        self.service.postCreateClient(model:  CreateClientModelV3(clients: [photmodel])).subscribe { (response) in
                            SVProgressHUD.dismiss()
                            if self.viewController != nil {
                                if response.success ?? false {
                                    NotificationCenter.default.post(name: NSNotification.Name.ClientsUpdate, object: nil, userInfo: nil)
                                    if self.viewController.delegate != nil {
                                        self.viewController.navigationController?.popToViewController((self.viewController.delegate?.fromVC)!, animated: true)
                                    } else {
                                        self.viewController.navigationController?.popViewController(animated: true)
                                    }
                                    
                                } else {
                                    SVProgressHUD.showError(withStatus: response.message)
                                }
                            }
                        } onError: { (error) in
                            SVProgressHUD.showError(withStatus: error.localizedDescription)
                        }.disposed(by: self.disposeBag)
                    } else {
                        SVProgressHUD.showError(withStatus: response.message)
                    }
                }
            } onError: { (error) in
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }.disposed(by: disposeBag)
        } else {
            service.postCreateClient(model: CreateClientModelV3(clients: [model] )).subscribe { (response) in
                SVProgressHUD.dismiss()
                if self.viewController != nil {
                    if response.success ?? false {
                        NotificationCenter.default.post(name: NSNotification.Name.ClientsUpdate, object: nil, userInfo: nil)
                        if self.viewController.delegate != nil {
                            self.viewController.navigationController?.popToViewController((self.viewController.delegate?.fromVC)!, animated: true)
                        } else {
                            self.viewController.navigationController?.popViewController(animated: true)
                        }
                    } else {
                        SVProgressHUD.showError(withStatus: response.message)
                    }
                }
            } onError: { (error) in
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }.disposed(by: disposeBag)
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

}
