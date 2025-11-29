//
//  RegInfoInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 09.09.2020.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD
import OneSignal

protocol RegInfoInteractorProtocol: class {
    func configureView()
    func configureView(with model: SphereModel)
    func openSphere()
    func registerAction()
    func setActive(active: Bool)
    func checkField(text: String)
}

class RegInfoInteractor: RegInfoInteractorProtocol {
    weak var viewController: RegInfoController!
    weak var presenter: RegInfoPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()

    init(viewController: RegInfoController, presenter: RegInfoPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
        let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: viewController.view.frame.size.width, height: 30))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(doneButtonAction))
        doneBtn.tintColor = UIColor(named: "appBlue")
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()

        viewController.nameField.inputAccessoryView = toolbar
        checkField(text: "NiL")
    }
    
    @objc func doneButtonAction() {
        viewController.view.endEditing(true)
    }
    
    func openSphere() {
        getSphereList()
    }
        
    func openApp() {
        viewController.model?.name = viewController.nameField.text
        register(model: viewController.model!)
    }
    
    func registerAction() {
        openApp()
    }
    
    func configureView(with model: SphereModel) {
        viewController.sphereLabel.text = model.name
        viewController.model?.sphereId = model.id
        let pushToken = OneSignal.getDeviceState().userId
        viewController.model?.pushToken = pushToken
        viewController.model?.password = Authorization.pass
        checkField(text: "NiL")
    }
    
    func setActive(active: Bool) {
        viewController.namePlate.isActiveBorder = active
    }
    
    func checkField(text: String) {
        if text != "NiL" {
            if text.count > 1 && viewController.sphereLabel.text?.count ?? 0 > 1 {
                viewController.regButton.isActive = true
            } else {
                viewController.regButton.isActive = false
            }
        } else {
            if viewController.nameField.text?.count ?? 0 > 1 && viewController.sphereLabel.text?.count ?? 0 > 1 {
                viewController.regButton.isActive = true
            } else {
                viewController.regButton.isActive = false
            }
        }
    }

    func setSubscriptionTrial(completion: @escaping (Bool) -> ()) {
        service.postSubTrial(id: 3).subscribe { (response) in
            if response.success ?? false {
                completion(true)
            } else {
                completion(false)
            }
        } onError: { (error) in
            completion(false)
        } onCompleted: {
        }.disposed(by: disposeBag)
    }
    
    func register(model: RegisterModel) {
        SVProgressHUD.show()
        service.postRegister(model: model).subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if !(response.success ?? true) {
                    SVProgressHUD.showError(withStatus: response.message)
                } else {
                    if response.data?.token?.count ?? 0 > 0 {
                        Authorization.token = response.data?.token
                        Authorization.name = response.data?.user?.name
                        Authorization.id = response.data?.user?.id
                        Authorization.phone = model.phone
                        
                        self.setSubscriptionTrial { isSettedFreeSub in
                            if isSettedFreeSub {
                                let vc = self.viewController.getController(controller: .subTrial)
                                self.viewController.view.endEditing(true)
                                self.viewController.presentOnRoot(vc)
                            } else {
                                let vc = self.viewController.getControllerAppNavigation(controller: .tabbar)
                                self.viewController.view.endEditing(true)
                                self.viewController.present(vc, animated: true, completion: nil)
                            }
                        }
                    }
                }
            }
        } onError: { (error) in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        } onCompleted: {
        }.disposed(by: disposeBag)
    }
    
    func getSphereList() {
        viewController.nameField.resignFirstResponder()
        if viewController.sphereList.count > 0 {
            let vc = viewController.getController(controller: .regsphere) as! RegSphereController
            vc.spherePresenter = presenter
            vc.sphereList = viewController.sphereList
            viewController.navigationController?.pushViewController(vc, animated: true)
        } else {
            service.getSpheres().subscribe { (response) in
                SVProgressHUD.dismiss()
                if self.viewController != nil {
                    if !(response.success ?? true) {
                        SVProgressHUD.showError(withStatus: response.message)
                    } else {
                        self.viewController.sphereList = response.data ?? []
                        let vc = self.viewController.getController(controller: .regsphere) as! RegSphereController
                        vc.spherePresenter = self.presenter
                        vc.sphereList = self.viewController.sphereList
                        self.viewController.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            } onError: { (error) in
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            } onCompleted: {
            }.disposed(by: disposeBag)
        }
    }
}
