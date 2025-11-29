//
//  OnlineRecordSettingsPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 01.12.2020.
//

import Foundation
import UIKit

protocol OnlineRecordSettingsPresenterProtocol: class {
    var router: OnlineRecordSettingsRouterProtocol! { get set }
    func configureView()
    func backAction()
    func openSite(with link: String)
    func sendEditedOnline()
}

class OnlineRecordSettingsPresenter: OnlineRecordSettingsPresenterProtocol {
    var router: OnlineRecordSettingsRouterProtocol!
    var interactor: OnlineRecordSettingsInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func openSite(with link: String) {
        interactor.openSite(with: link)
    }
    
    func sendEditedOnline() {
        interactor.sendEditedOnline()
    }
}


