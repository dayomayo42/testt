//
//  SupportInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 27.10.2020.
//

import Foundation
import UIKit
import SVProgressHUD
protocol SupportInteractorProtocol: class {
    func configureView()
    func openAnswer()
    func openFeedback()
}

class SupportInteractor: SupportInteractorProtocol {
    weak var viewController: SupportController!
    weak var presenter: SupportPresenterProtocol!
    
    init(viewController: SupportController, presenter: SupportPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
    }
    
    func openAnswer() {
        let vc = viewController.getControllerProfile(controller: .answer)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openFeedback() {
//        let vc = viewController.getControllerProfile(controller: .feedback)
//        viewController.navigationController?.pushViewController(vc, animated: true)
        
        let alert = UIAlertController(title: "Обратная связь", message: "Выберите способ связи", preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Напрямую", style: .default, handler: { _ in
            let vc = self.viewController.getControllerProfile(controller: .feedback)
            self.viewController.navigationController?.pushViewController(vc, animated: true)
        }))

        alert.addAction(UIAlertAction(title: "WhatsApp", style: .default, handler: { _ in
            let phoneNumber =  "+79850658415"
            let appURL = URL(string: "https://api.whatsapp.com/send?phone=\(phoneNumber)")!
            if UIApplication.shared.canOpenURL(appURL) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
                }
                else {
                    UIApplication.shared.openURL(appURL)
                }
            } else {
                SVProgressHUD.showError(withStatus: "WhatsApp не установлен")
                // WhatsApp is not installed
            }
        }))

        alert.addAction(UIAlertAction(title: "Telegram", style: .default, handler: { _ in
            let screenName =  "ProfAppPro"
            let appURL = NSURL(string: "tg://resolve?domain=\(screenName)")!
            let webURL = NSURL(string: "https://t.me/\(screenName)")!
            if UIApplication.shared.canOpenURL(appURL as URL) {
                UIApplication.shared.open(appURL as URL, options: [:], completionHandler: nil)
            }
            else {
                //redirect to safari because the user doesn't have Telegram
                UIApplication.shared.open(webURL as URL, options: [:], completionHandler: nil)
            }
        }))

        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))

        viewController.present(alert, animated: true)
    }
}

