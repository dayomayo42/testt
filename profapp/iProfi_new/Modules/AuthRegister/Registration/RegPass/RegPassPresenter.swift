//
//  RegPassPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 03.09.2020.
//

import Foundation
import UIKit

protocol RegPassPresenterProtocol: class {
    var router: RegPassRouterProtocol! {get set}
    func configureView()
    func repeatePass()
    func onViewDissapear()
    func makeCall()
}

class RegPassPresenter: RegPassPresenterProtocol {
    
    var router: RegPassRouterProtocol!
    var interactor: RegPassInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func repeatePass() {
        interactor.repeatePass()
    }
    
    func onViewDissapear() {
        interactor.onViewDissapear()
    }
    
    func makeCall() {
        router.makeCall()
    }
}
