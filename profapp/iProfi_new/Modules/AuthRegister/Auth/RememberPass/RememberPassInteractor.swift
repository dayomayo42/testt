//
//  RemamberPassInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 01.09.2020.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD
import PhoneNumberKit

protocol RememberPassInteractorProtocol: class {
    func configureView(with model: CountriesModel?)
    func toCountryList()
    func openComplete(with number: String)
    func checkFields(current: String, viewTag: Int)
    func setActive(tag: Int)
}

class RememberPassInteractor: RememberPassInteractorProtocol {
    weak var viewController: RememberPassController!
    var presenter: RememberPassPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    let phoneNumberKit = PhoneNumberKit()
    
    init(viewController: RememberPassController, presenter: RememberPassPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }

    func configureView(with model: CountriesModel?) {
        if model != nil {
            viewController.numberField.text = ""
        } else {
            let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: viewController.view.frame.size.width, height: 30))
            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(doneButtonAction))
            doneBtn.tintColor = UIColor(named: "appBlue")
            toolbar.setItems([flexSpace, doneBtn], animated: false)
            toolbar.sizeToFit()

            viewController.numberField.inputAccessoryView = toolbar

            viewController.numberField.setup()
        }
    }
    
    func checkFields(current: String, viewTag: Int) {
        if viewTag == 0 {
            if current.count > 3 {
                viewController.enterButton.isActive = true
            } else {
                viewController.enterButton.isActive = false
            }
        } else if viewTag == 2 {
            if viewController.numberField.text?.count ?? 0 > 3 {
                viewController.enterButton.isActive = true
            } else {
                viewController.enterButton.isActive = false
            }
        }
    }

    func toCountryList() {
        let vc = viewController.getController(controller: .country) as! ChooseCountryController
        vc.authPresenter = presenter
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setActive(tag: Int) {
        if tag == 0 {
            viewController.numberPlate.isActiveBorder = true
        } else if tag == 2 {
            viewController.numberPlate.isActiveBorder = false
        }
    }
    
    @objc func doneButtonAction() {
        viewController.view.endEditing(true)
    }
    
    func openComplete(with number: String) {
        rememberPass(phone: number)
    }
    
    func rememberPass(phone: String) {
        var convertedPhone = ""
        if phone.count > 0 {
            do {
                let phoneNumber = try phoneNumberKit.parse(phone)
                convertedPhone = phoneNumberKit.format(phoneNumber, toType: .e164)
            } catch let error {
                debugPrint(error)
                return
            }
        }
        service.postRememberPass(phone: convertedPhone).subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    let vc = self.viewController.getController(controller: .remembersuccess) as! RememberSuccessController
                    vc.phoneNumber = phone
                    self.viewController.navigationController?.pushViewController(vc, animated: true)
                } else {
                    SVProgressHUD.showError(withStatus: response.message ?? "")
                }
            }
        } onError: { (error) in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        } onCompleted: {
        }.disposed(by: disposeBag)

    }

}
