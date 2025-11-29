//
//  RegPhonePresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 02.09.2020.
//

import Foundation
import UIKit

protocol RegPhonePresenterProtocol: ChooseCountryDelegate {
    var router: RegPhoneRouterProtocol! {get set}
    func openChooseCountry()
    func checkFields(current: String, viewTag: Int)
    func setActive(tag: Int)
    func toSMSCode()
}

class RegPhonePresenter: RegPhonePresenterProtocol {
    var router: RegPhoneRouterProtocol!
    var interactor: RegPhoneInteractorProtocol!
    
    func configureView(from model: CountriesModel?) {
        interactor.configureView(with: model)
    }
    
    func openChooseCountry() {
        interactor.toCountryList()
    }
    
    func checkFields(current: String, viewTag: Int) {
        interactor.checkFields(current: current, viewTag: viewTag)
    }
    
    func setActive(tag: Int) {
        interactor.setActive(tag: tag)
    }
    
    func toSMSCode() {
        interactor.toSMSCode()
    }
}
