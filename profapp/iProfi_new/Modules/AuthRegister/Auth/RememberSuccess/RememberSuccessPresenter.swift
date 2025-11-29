//
//  RememberSuccessPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 02.09.2020.
//

import Foundation
import UIKit

protocol RememberSuccessPresenterProtocol: class {
    var router: RememberSuccessRouterProtocol! {get set}
    func configureView(with number: String)
    func dismissAction()
}

class RememberSuccessPresenter: RememberSuccessPresenterProtocol {
    var router: RememberSuccessRouterProtocol!
    var interactor: RememberSuccessInteractorProtocol!
   
    func configureView(with number: String) {
        interactor.configureView(with: number)
    }
    
    func dismissAction() {
        router.dismiss()
    }
}
