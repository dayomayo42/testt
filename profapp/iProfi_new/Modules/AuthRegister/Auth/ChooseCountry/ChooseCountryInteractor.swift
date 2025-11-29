//
//  ChooseCountryInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 31.08.2020.
//

import Foundation
import UIKit

protocol ChooseCountryInteractorProtocol: class {
}

class ChooseCountryInteractor: ChooseCountryInteractorProtocol {
    
    weak var viewController: ChooseCountryController!
    weak var presenter: ChooseCountryPresenterProtocol!
    
    init(viewController: ChooseCountryController, presenter: ChooseCountryPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
}
