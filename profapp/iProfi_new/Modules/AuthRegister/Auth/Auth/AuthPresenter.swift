//
//  AuthPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 28.08.2020.
//

import Foundation
import UIKit

protocol ChooseCountryDelegate {
    func configureView(from model: CountriesModel?)
}

protocol AuthPresenterProtocol: ChooseCountryDelegate {
    var router: AuthRouterProtocol! {get set}
    func openChooseCountry()
    func openApp()
    func openRemember()
    func checkFields(current: String, viewTag: Int)
    func setActive(tag: Int)
    func testAuth()
}

class AuthPresenter: AuthPresenterProtocol {
    var router: AuthRouterProtocol!
    var interactor: AuthInteractorProtocol!
   
    func configureView(from model: CountriesModel?) {
        interactor.configureView(with: model)
    }
    
    func checkFields(current: String, viewTag: Int) {
        interactor.checkFields(current: current, viewTag: viewTag)
    }
    
    func openChooseCountry() {
        interactor.toCountryList()
    }
    
    func openApp() {
        interactor.openApp()
    }
    
    func setActive(tag: Int) {
        interactor.setActive(tag: tag)
    }
    
    func openRemember() {
        interactor.openRemember()
    }
    
    func testAuth() {
        interactor.testAuth()
    }
}
