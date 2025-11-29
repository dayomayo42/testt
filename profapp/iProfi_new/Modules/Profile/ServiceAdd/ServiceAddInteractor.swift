//
//  ServiceAddInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 15.10.2020.
//

import Foundation
import Moya
import RxSwift
import SVProgressHUD
import UIKit

struct ServiceTimes {
    let title: String?
    let minutes: Int?
}

protocol ServiceAddInteractorProtocol: class {
    func configureView()
    func checkField()
    func addService()
}

class ServiceAddInteractor: ServiceAddInteractorProtocol {
    weak var viewController: ServiceAddController!
    weak var presenter: ServiceAddPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()

    init(viewController: ServiceAddController, presenter: ServiceAddPresenterProtocol) {
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

        viewController.actionButton.isActive = false

        viewController.pickerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        viewController.pickerView.alpha = 0.85
        viewController.pickerView.dataSource = viewController
        viewController.pickerView.delegate = viewController

        viewController.nameField.inputAccessoryView = toolbar
        viewController.priceField.inputAccessoryView = toolbar
        viewController.durationField.inputAccessoryView = toolbar // TODO: добавить пикер точеный
        viewController.durationField.inputView = viewController.pickerView
        viewController.currencyLabel.text = Settings.currency
    }

    @objc func doneButtonAction() {
        viewController.view.endEditing(true)
    }

    func checkField() {
        if viewController.nameField.text?.count ?? 0 > 0 && viewController.priceField.text?.count ?? 0 > 0 && viewController.durationField.text?.count ?? 0 > 0 {
            viewController.actionButton.isActive = true
        } else {
            viewController.actionButton.isActive = false
        }
    }

    func addService() {
        postService(name: viewController.nameField.text ?? "", price: viewController.priceField.text?.toInt() ?? 0, duration: viewController.minutesInt)
    }

    func postService(name: String, price: Int, duration: Int) {
        SVProgressHUD.show()
        service.postService(name: name, price: price, duration: duration).subscribe { response in
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
