//
//  AuthInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 28.08.2020.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD
import OneSignal
import PhoneNumberKit

protocol AuthInteractorProtocol: class {
    func configureView(with model: CountriesModel?)
    func toCountryList()
    func openApp()
    func openRemember()
    func checkFields(current: String, viewTag: Int)
    func setActive(tag: Int)
    func testAuth()
}

class AuthInteractor: AuthInteractorProtocol {
    weak var viewController: AuthController!
    var presenter: AuthPresenterProtocol!
    let serverService: ServerServiceProtocol = ServerService()
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    let phoneNumberKit = PhoneNumberKit()
    
    init(viewController: AuthController, presenter: AuthPresenterProtocol) {
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
            viewController.passField.inputAccessoryView = toolbar
            viewController.numberField.setup()
            viewController.passField.delegate = viewController

//            viewController.listener.affinityCalculationStrategy = .prefix
//            viewController.listener.affineFormats = [
//                "+7[000][000][00][00]",
//            ]
//
//            viewController.listener.primaryMaskFormat = "+7[000][000][00][00]"
        }
    }

    func checkFields(current: String, viewTag: Int) {
        if viewTag == 0 {
            if current.count > 3 && viewController.passField.text?.count ?? 0 > 2 {
                viewController.enterButton.isActive = true
            } else {
                viewController.enterButton.isActive = false
            }
        } else if viewTag == 1 {
            if viewController.numberField.text?.count ?? 0 > 2 && current.count > 2 {
                viewController.enterButton.isActive = true
            } else {
                viewController.enterButton.isActive = false
            }
        } else if viewTag == 2 {
            if viewController.numberField.text?.count ?? 0 > 2 && viewController.passField.text?.count ?? 0 > 2 {
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
            viewController.passPlate.isActiveBorder = false
        } else if tag == 2 {
            viewController.numberPlate.isActiveBorder = false
            viewController.passPlate.isActiveBorder = false
        } else if tag == 1 {
            viewController.numberPlate.isActiveBorder = false
            viewController.passPlate.isActiveBorder = true
        }
    }

    @objc func doneButtonAction() {
        viewController.view.endEditing(true)
    }

    func openRemember() {
        let vc = viewController.getController(controller: .remember)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func auth(phone: String, code: String) {
//        SVProgressHUD.show()
//        var convertedPhone = ""
//        if phone.count > 0 {
//            let phoneNumber = try! phoneNumberKit.parse(phone)
//            convertedPhone = phoneNumberKit.format(phoneNumber, toType: .e164)
//        }
//        let status: OSPermissionSubscriptionState = OneSignal.getPermissionSubscriptionState()
//        let pushToken = status.subscriptionStatus.userId ?? ""
//        service.postAuth(phone: convertedPhone, pushToken: pushToken).subscribe { (response) in
//            SVProgressHUD.dismiss()
//            if self.viewController != nil {
//                if !(response.success ?? false) {
//                    SVProgressHUD.showError(withStatus: response.message)
//                } else {
//                    if response.data?.token?.count ?? 0 > 0 {
//                        Authorization.token = response.data?.token
//                        Authorization.name = response.data?.user?.name
//                        Authorization.midname = response.data?.user?.midname
//                        Authorization.lastame = response.data?.user?.lastname
//                        Authorization.id = response.data?.user?.id
//                        Authorization.phone = phone
//                        Settings.subType = response.data?.user?.subscription?.subscription?.key
//                        Authorization.useraddress = response.data?.user?.address
//                        Authorization.email = response.data?.user?.email
//                        let vc = self.viewController.getControllerAppNavigation(controller: .tabbar)
//                        self.viewController.view.endEditing(true)
//                        self.viewController.present(vc, animated: true, completion: nil)
//                    }
//                }
//            }
//        } onError: { (error) in
//            SVProgressHUD.showError(withStatus: error.localizedDescription)
//        } onCompleted: {
//        }.disposed(by: disposeBag)
    }

    func openApp() {
        viewController.view.endEditing(true)
        auth(phone: viewController.numberField.text ?? "", code: viewController.passField.text ?? "")
    }
    
    func testAuth() {
        auth(phone: "+79997353051", code: "743405")
    }
}
