//
//  RecordTimePresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 05.11.2020.
//

import Foundation
import UIKit

protocol RecordTimePresenterProtocol: class {
    var router: RecordTimeRouterProtocol! { get set }
    func configureView()
    func backAction()
}

class RecordTimePresenter: RecordTimePresenterProtocol {
    var router: RecordTimeRouterProtocol!
    var interactor: RecordTimeInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
}

