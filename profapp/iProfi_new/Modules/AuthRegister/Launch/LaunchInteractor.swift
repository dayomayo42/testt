//
//  LaunchInteractor.swift
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

protocol LaunchInteractorProtocol: class {
    func toAuth()
    func toRegister()
    func openSite(with urlString: String)
    func configureView()
    func postAuth(phone: String)
    func checkIsNumberValid(phone: String)
    func optimiseForLowHeightDevice()
}

class LaunchInteractor: LaunchInteractorProtocol {
    
    weak var viewController: LaunchController!
    weak var presenter: LaunchPresenterProtocol!
    let serverService: ServerServiceProtocol = ServerService()
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    let phoneNumberKit = PhoneNumberKit()
    
    init(viewController: LaunchController, presenter: LaunchPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func toAuth() {
        let vc = viewController.getController(controller: .auth)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func checkIsNumberValid(phone: String) {
        if phoneNumberKit.isValidPhoneNumber(phone) {
            viewController.authButton.isActive = true
        } else {
            viewController.authButton.isActive = false
        }
    }
    
    func optimiseForLowHeightDevice() {
        guard let vc = viewController else { return }
        let screenHeight = UIScreen.main.bounds.height
            switch screenHeight {
            case 667:
                vc.centerStackViewContstraint.constant = 65
            case 568:
                vc.centerStackViewContstraint.constant = 75
            default:
                break
            }
    }
    
    func presentTestAccountAlert(convertedNumber: String, response: SendCallModel) {
        let alert = UIAlertController(title: "Тестовый аккаунт, звонок не требуется", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Продолжить", style: .default, handler: { _ in
            var model = RegisterModel()
            model.phone = convertedNumber
            let vc = self.viewController.getController(controller: .regpass) as! RegPassController
            vc.model = model
            vc.callModel = response
            vc.isTestNumber = true
            self.viewController.navigationController?.pushViewController(vc, animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        
        viewController.present(alert, animated: true, completion: nil)
    }
    
    func toRegister() {
        let vc = viewController.getController(controller: .regphone)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openSite(with urlString: String) {
        serverService.openUrl(with: urlString)
    }
    
    func configureView() {
        guard let vc = viewController else { return }
        vc.phoneField.setup()
//        if Authorization.isAuthorized {
//            openApp()
//        }
        
        vc.descTextView.textContainerInset.left = -4
        vc.descTextView.addHyperLinksToText(originalText: "При регистрации в приложении вы даете согласие на политику конфиденциальности и обработку персональных данных", hyperLinks: ["политику конфиденциальности": "https://profapp.app/doc/policy.pdf", "обработку персональных данных" : "https://profapp.app/doc/agreement.pdf"], font: UIFont.systemFont(ofSize: 13, weight: .regular))
        vc.descTextView.textAlignment = .center
        
        
        let originalText = NSMutableAttributedString(attributedString: vc.descTextView.attributedText)
        var newString = NSMutableAttributedString(attributedString: vc.descTextView.attributedText)

        originalText.enumerateAttributes(in: NSRange(0..<originalText.length), options: .reverse) { (attributes, range, pointer) in
            if let _ = attributes[NSAttributedString.Key.link] {
                newString.removeAttribute(NSAttributedString.Key.font, range: range)
                newString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 13, weight: .semibold), range: range)
            }
        }
        vc.descTextView.attributedText = newString
        
        
        
        let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: vc.view.frame.size.width, height: 30))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(doneButtonAction))
        doneBtn.tintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        vc.phoneField.inputAccessoryView = toolbar
    }
    
    func openApp() {
//        let vc = viewController.getControllerAppNavigation(controller: .tabbar)
//        UIApplication.shared.keyWindow?.rootViewController = vc
    }
    
    @objc func doneButtonAction() {
        viewController.view.endEditing(true)
    }
    
    func postAuth(phone: String) {
        SVProgressHUD.show()
        var convertedPhone = ""
        if phoneNumberKit.isValidPhoneNumber(phone) {
            if phone.count > 0 {
                do {
                    let phoneNumber = try phoneNumberKit.parse(phone)
                    convertedPhone = phoneNumberKit.format(phoneNumber, toType: .e164)
                } catch let error {
                    debugPrint(error)
                    return
                }
            }
        }
        let pushToken = OneSignal.getDeviceState().userId
        service.postSendCall(phone: convertedPhone).subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if !(response.success ?? false) {
//                    SVProgressHUD.showError(withStatus: response.message)
                } else {
                    
                    if response.confirmNumber == convertedPhone.replacingOccurrences(of: "+", with: "") {
                        self.presentTestAccountAlert(convertedNumber: convertedPhone, response: response)
                    } else {
                        var model = RegisterModel()
                        model.phone = convertedPhone
                        let vc = self.viewController.getController(controller: .regpass) as! RegPassController
                        vc.model = model
                        vc.callModel = response
                        self.viewController.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
        } onError: { (error) in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        } onCompleted: {
        }.disposed(by: disposeBag)
    }
}
