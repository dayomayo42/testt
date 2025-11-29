//
//  OnlineRecordInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 29.10.2020.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD

protocol OnlineRecordInteractorProtocol: class {
    func configureView()
    func openTime()
    func shareLink()
    func configureView(with model: CountriesModel?)
    func toCountryList()
    func sendEdited()
    func openSubs()
}

class OnlineRecordInteractor: OnlineRecordInteractorProtocol {
    weak var viewController: OnlineRecordController!
    var presenter: OnlineRecordPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    
    init(viewController: OnlineRecordController, presenter: OnlineRecordPresenterProtocol) {
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
        
//        if Settings.subType?.contains("online") ?? false {
            viewController.subPlate.isHidden = true
            viewController.scrollView.isHidden = false
//        } else {
//            viewController.subPlate.isHidden = false
//            viewController.scrollView.isHidden = true
//
//            if viewController.userModel?.isFirstSub == 0 {
//                viewController.margin.constant = 32
//            } else {
//                viewController.margin.constant = 64
//            }
//        }
        
        viewController.whatsAppField.setup()
        viewController.whatsAppField.delegate = viewController
//        viewController.listener.affinityCalculationStrategy = .prefix
//        viewController.listener.affineFormats = [
//            "+7[000][000][00][00]",
//        ]
//
//        viewController.listener.primaryMaskFormat = "+7[000][000][00][00]"
        
        viewController.whatsAppField.inputAccessoryView = toolbar
        viewController.vkField.inputAccessoryView = toolbar
        viewController.instaField.inputAccessoryView = toolbar
        viewController.fbField.inputAccessoryView = toolbar
        viewController.aboutField.inputAccessoryView = toolbar
        
        let model = viewController.userModel
        viewController.siteLink.text = model?.siteLink
        viewController.whatsAppField.text = model?.phone
        viewController.vkField.text = model?.vk?.contains("vk.com") ?? false ? model?.vk : "vk.com/"
        viewController.instaField.text = model?.instagram?.contains("instagram.com") ?? false ? model?.instagram : "instagram.com/"
        viewController.fbField.text = model?.fb?.contains("facebook.com") ?? false ? model?.fb : "facebook.com/"
        viewController.aboutField.text = model?.about
//        viewController.
        
    }
    
    @objc func doneButtonAction() {
        viewController.view.endEditing(true)
    }
    
    func openTime() {
        let vc = viewController.getControllerProfile(controller: .recordtime)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func shareLink() {
        if viewController.userModel?.address?.count ?? 0 > 0 && viewController.userModel?.city?.count ?? 0 > 0 {
            let shareText = viewController.userModel?.siteLink ?? ""
            let vc = UIActivityViewController(activityItems: [shareText], applicationActivities: [])
            viewController.present(vc, animated: true)
        } else {
            let dialogMessage = UIAlertController(title: "Ошибка", message: "Необходимо заполнить поля \"Город\" и \"Адрес\" в профиле", preferredStyle: .alert)
            
             let ok = UIAlertAction(title: "Закрыть", style: .default, handler: { (action) -> Void in

              })
             dialogMessage.addAction(ok)
             viewController.present(dialogMessage, animated: true, completion: nil)
        }
        
    }
    
    
    func configureView(with model: CountriesModel?) {
        viewController.whatsAppField.text = ""
//        viewController.listener.primaryMaskFormat = "+\(model?.phoneMask ?? "")[000][000][000][000]"
    }
    
    func toCountryList() {
        let vc = viewController.getController(controller: .country) as! ChooseCountryController
        vc.authPresenter = presenter
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func sendEdited() {
        SVProgressHUD.show()
        viewController.userModel?.phone = viewController.whatsAppField.text
        viewController.userModel?.vk = viewController.vkField.text
        viewController.userModel?.instagram = viewController.instaField.text
        viewController.userModel?.fb = viewController.fbField.text
        viewController.userModel?.about = viewController.aboutField.text
        service.postEditedModel(model: viewController.userModel!).subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    self.viewController.navigationController?.popViewController(animated: true)
                } else {
                    SVProgressHUD.showError(withStatus: response.message)
                }
            }
        } onError: { (error) in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    func openSubs() {
        if viewController != nil {
            let vc = viewController.getControllerProfile(controller: .subscription)
            viewController.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

