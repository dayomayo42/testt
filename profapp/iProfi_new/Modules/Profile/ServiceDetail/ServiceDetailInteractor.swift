//
//  ServiceDetailInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 15.10.2020.
//

import Foundation
import Moya
import RxSwift
import SVProgressHUD
import UIKit

protocol ServiceDetailInteractorProtocol: class {
    func configureView()
    func editMode(edit: Bool)
    func deleteAction(id: Int)
}

class ServiceDetailInteractor: ServiceDetailInteractorProtocol {
    weak var viewController: ServiceDetailController!
    weak var presenter: ServiceDetailPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()

    init(viewController: ServiceDetailController, presenter: ServiceDetailPresenterProtocol) {
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

        viewController.pickerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        viewController.pickerView.alpha = 0.85
        viewController.pickerView.dataSource = viewController
        viewController.pickerView.delegate = viewController

        viewController.nameField.inputAccessoryView = toolbar
        viewController.priceField.inputAccessoryView = toolbar
        viewController.durationField.inputAccessoryView = toolbar
        viewController.durationField.inputView = viewController.pickerView

        viewController.nameField.text = viewController.model?.name
        viewController.priceField.text = "\(viewController.model?.price ?? 0)"
        for item in viewController.timesArray{
            if item.minutes == viewController.model?.duration  {
                viewController.durationField.text = item.title
            }
        }
        viewController.titleLabel.text = viewController.model?.name
        viewController.currencyLabel.text = Settings.currency
    }

    @objc func doneButtonAction() {
        viewController.view.endEditing(true)
    }

    func editMode(edit: Bool) {
        if viewController.isEditMode {
            viewController.titleLabel.text = viewController.nameField.text ?? ""
            let dur = viewController.minutesInt == 0 ? viewController.model?.duration : viewController.minutesInt
            postEditService(id: viewController.model?.id ?? 0, name: viewController.nameField.text ?? "", price: viewController.priceField.text?.toInt() ?? 0, duration: dur ?? 0)
        }
        viewController.isEditMode = edit
        if edit {
            viewController.namePlate.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            viewController.pricePlate.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            viewController.durationPlate.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            viewController.namePlate.isUserInteractionEnabled = true
            viewController.pricePlate.isUserInteractionEnabled = true
            viewController.durationPlate.isUserInteractionEnabled = true
            viewController.editButton.setTitle("Сохранить", for: .normal)
            viewController.editButton.setImage(UIImage(), for: .normal)
        } else {
            viewController.namePlate.isUserInteractionEnabled = false
            viewController.pricePlate.isUserInteractionEnabled = false
            viewController.durationPlate.isUserInteractionEnabled = false
            viewController.editButton.setTitle("", for: .normal)
            viewController.editButton.setImage(#imageLiteral(resourceName: "pen"), for: .normal)
            viewController.namePlate.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9882352941, blue: 1, alpha: 1)
            viewController.pricePlate.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9882352941, blue: 1, alpha: 1)
            viewController.namePlate.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9882352941, blue: 1, alpha: 1)
            viewController.durationPlate.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9882352941, blue: 1, alpha: 1)
            viewController.view.endEditing(true)
        }
    }

    func deleteAction(id: Int) {
        deleteService(id: id)
    }

    func postEditService(id: Int, name: String, price: Int, duration: Int) {
        SVProgressHUD.show()
        service.postEditService(id: id, name: name, price: price, duration: duration).subscribe { response in
            SVProgressHUD.dismiss()
            if !(response.success ?? false) {
                SVProgressHUD.showError(withStatus: response.message)
            } else {
                NotificationCenter.default.post(name: NSNotification.Name.ServicesUpdate, object: nil, userInfo: nil)
            }
        } onError: { error in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }

    func deleteService(id: Int) {
        SVProgressHUD.show()
        service.postDeleteService(id: id).subscribe { response in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    NotificationCenter.default.post(name: NSNotification.Name.ServicesUpdate, object: nil, userInfo: nil)
                    self.viewController.navigationController?.popViewController(animated: true)
                } else {
                    SVProgressHUD.showError(withStatus: response.message)
                }
            }
        } onError: { error in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
}
