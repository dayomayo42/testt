//
//  LaunchPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 28.08.2020.
//

import Foundation
import UIKit

protocol LaunchPresenterProtocol: class {
    var router: LaunchRouterProtocol! {get set}
    func configureView()
    func authClicked()
    func registerClicked()
    func logoClicked(with urlString: String?)
    func postAuth(phone: String)
    func checkIsNumberValid(phone: String)
    func optimiseForLowHeightDevice()
}

class LaunchPresenter: LaunchPresenterProtocol {
    var router: LaunchRouterProtocol!
    var interactor: LaunchInteractorProtocol!
   
    func checkIsNumberValid(phone: String) {
        interactor.checkIsNumberValid(phone: phone)
    }
    
    func configureView() {
        interactor.configureView()
    }
    
    func authClicked() {
        interactor.toAuth()
    }
    
    func registerClicked() {
        interactor.toRegister()
    }
    
    
    func logoClicked(with urlString: String?) {
        if let url = urlString {
            interactor.openSite(with: url)
        }
    }
    
    func postAuth(phone: String) {
        interactor.postAuth(phone: phone)
    }
    
    func optimiseForLowHeightDevice() {
        interactor.optimiseForLowHeightDevice()
    }
}
