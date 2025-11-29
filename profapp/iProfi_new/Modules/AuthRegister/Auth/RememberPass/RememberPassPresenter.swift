//
//  RemamberPassPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 01.09.2020.
//

import Foundation
import UIKit

protocol RememberPassPresenterProtocol: ChooseCountryDelegate {
    var router: RememberPassRouterProtocol! {get set}
    func openChooseCountry()
    func openComplete(with number: String)
    func checkFields(current: String, viewTag: Int)
    func setActive(tag: Int)
}

class RememberPassPresenter: RememberPassPresenterProtocol {
    var router: RememberPassRouterProtocol!
    var interactor: RememberPassInteractorProtocol!
    
    func configureView(from model: CountriesModel?) {
        interactor.configureView(with: model)
    }
    
    
    func openChooseCountry() {
        interactor.toCountryList()
    }
    
    func openComplete(with number: String) {
        interactor.openComplete(with: number)
    }
    
    func checkFields(current: String, viewTag: Int) {
        interactor.checkFields(current: current, viewTag: viewTag)
    }
    
    func setActive(tag: Int) {
        interactor.setActive(tag: tag)
    }
}
