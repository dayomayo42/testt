//
//  RegPassInterctor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 03.09.2020.
//

import Foundation
import Moya
import RxSwift
import SVProgressHUD
import UIKit
import OneSignal
import PhoneNumberKit

protocol RegPassInteractorProtocol: class {
    func configureView()
    func repeatePass()
    func onViewDissapear()
}

class RegPassInteractor: RegPassInteractorProtocol {
    weak var viewController: RegPassController!
    weak var presenter: RegPassPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    private let phoneNumberKit = PhoneNumberKit()
    var timer: Timer?
    var callbacksTimer: Timer?
    var timeLeft = 0
    let timerCount = 60

    init(viewController: RegPassController, presenter: RegPassPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }

    func configureView() {
        viewController.timerPlate.isHidden = true
        
        convertConfirmationPhone()
        
        createTimer(isSensSMSNeeded: false)
        createLoopCallback()
    }
    
    func convertConfirmationPhone() {
        let phone = "+\(viewController.callModel?.confirmNumber ?? "")"
        do {
            let phoneNumber = try phoneNumberKit.parse(phone)
            let formattedPhone = phoneNumberKit.format(phoneNumber, toType: .national)
            viewController.confirmationNumberPhoneLabel.text = formattedPhone
        } catch let error {
            viewController.confirmationNumberPhoneLabel.text = "Ошибка телефон не опознан"
            return
        }
    }

    @objc func doneButtonAction() {
        viewController.view.endEditing(true)
    }

    func checkField(text: String) {
        if text.count > 3 {
            viewController.nextButton.isActive = true
        } else {
            viewController.nextButton.isActive = false
        }
    }
    
    func onViewDissapear() {
        timer?.invalidate()
        callbacksTimer?.invalidate()
    }

    func repeatePass() {
        createTimer(isSensSMSNeeded: true)
    }

    func sendSMS(phone: String) {
        SVProgressHUD.show()
        service.postSendCall(phone: phone).subscribe { response in
            if !(response.success ?? true) {
//                SVProgressHUD.showError(withStatus: response.message)
            } else {
                self.viewController.callModel = response
                self.convertConfirmationPhone()
            }
        } onError: { error in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        } onCompleted: {
            SVProgressHUD.dismiss()
        }.disposed(by: disposeBag)
    }
    
    func sendCallback() {
        guard let phone = viewController.model?.phone, let callID = viewController.callModel?.callID else { return }
        
        let pushToken = OneSignal.getDeviceState().userId ?? ""
        service.postCheckCode(callID: callID, pushToken: pushToken).subscribe { response in
            if self.viewController != nil {
                if !(response.success ?? false) {
//                    SVProgressHUD.showError(withStatus: response.message)
                } else {
                    if response.data?.token?.count ?? 0 > 0 {
                        
                        self.callbacksTimer?.invalidate()
                        self.callbacksTimer = nil
                        
                        let notification = response.data?.user?.notifications
                        let reminderClient = response.data?.user?.reminderClient
                        
                        Authorization.name = response.data?.user?.name
                        Authorization.midname = response.data?.user?.midname
                        Authorization.lastame = response.data?.user?.lastname
                        Authorization.id = response.data?.user?.id
                        Authorization.phone = phone
                        Settings.subType = response.data?.user?.subscription?.type?.key
                        Settings.subTrialExp = response.data?.user?.trialExp
                        Authorization.useraddress = response.data?.user?.address
                        Authorization.email = response.data?.user?.email
                     
                        if response.data?.user?.name?.count ?? 0 > 0 {
                            Authorization.token = response.data?.token
                            let vc = self.viewController.getControllerAppNavigation(controller: .tabbar) as! TabBarController
                            
                            if notification ?? false || reminderClient ?? false {
                                if let profileTab = vc.tabBar.items?.last {
                                    vc.addRedDotAtTabBarItemIndex(index: vc.tabBar.items!.count - 1)
                                }
                            }
                            
                            self.viewController.view.endEditing(true)
                            self.viewController.present(vc, animated: true, completion: nil)
                        } else {
                            let vc = self.viewController.getController(controller: .reginfo) as! RegInfoController
                            vc.model = self.viewController.model
                            self.viewController.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                }
            }
        } onError: { error in
            print(error)
        } onCompleted: {
        }.disposed(by: disposeBag)
    }
    
    func createLoopCallback() {
        guard let vc = viewController else { return }
        
        callbacksTimer?.invalidate()
        
        if callbacksTimer == nil {
            
            callbacksTimer = Timer.scheduledTimer(timeInterval: vc.isTestNumber ? 0.3 : 5.0,
                                                  target: self,
                                                  selector: #selector(callbacksLoop),
                                                  userInfo: nil,
                                                  repeats: true)
        }
    }

    func createTimer(isSensSMSNeeded: Bool) {
        viewController.repeatePassButton.isHidden = true
        viewController.timerPlate.isHidden = false
        if isSensSMSNeeded {
            sendSMS(phone: viewController.model?.phone ?? "")
        }
        timeLeft = timerCount
        viewController.timerText.text = "Получение номера можно осуществить через \(timeLeft) секунд"
        if timer == nil {
            
            timer = Timer.scheduledTimer(timeInterval: 1.0,
                                         target: self,
                                         selector: #selector(updateTimer),
                                         userInfo: nil,
                                         repeats: true)
            RunLoop.current.add(timer!, forMode: .common)
            timer!.tolerance = 0.1
        }
    }

    @objc func updateTimer() {
        timeLeft -= 1
        viewController.timerText.text = "Получение номера можно осуществить через \(timeLeft) секунд"

        if timeLeft <= 0 {
            timer!.invalidate()
            viewController.repeatePassButton.isHidden = false
            viewController.timerPlate.isHidden = true
            timer = nil
        }
    }
    
    @objc func callbacksLoop() {
        sendCallback()
    }
}
