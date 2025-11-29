//
//  OnlineRecordSettingsInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 01.12.2020.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD

protocol OnlineRecordSettingsInteractorProtocol: class {
    func configureView()
    func openSite(with link: String)
    func sendEditedOnline()
}

class OnlineRecordSettingsInteractor: OnlineRecordSettingsInteractorProtocol {
    weak var viewController: OnlineRecordSettingsController!
    weak var presenter: OnlineRecordSettingsPresenterProtocol!
    let serverService: ServerServiceProtocol = ServerService()
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    
    init(viewController: OnlineRecordSettingsController, presenter: OnlineRecordSettingsPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
        viewController.siteLabel.text = viewController.userModel?.siteLink
        viewController.onlineSwitch.isOn = Settings.onlinerecord == 0 ? false : true
    }
    
    func openSite(with link: String) {
        serverService.openUrl(with: link)
    }
    
    func sendEditedOnline() {
        SVProgressHUD.show()
        Settings.onlinerecord = viewController.onlineSwitch.isOn ? 1 : 0
        viewController.userModel?.onlineRecord = viewController.onlineSwitch.isOn ? 1 : 0
        service.postEditedModel(model: viewController.userModel!).subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    
                } else {
                    SVProgressHUD.showError(withStatus: response.message)
                }
            }
        } onError: { (error) in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)

    }
}


