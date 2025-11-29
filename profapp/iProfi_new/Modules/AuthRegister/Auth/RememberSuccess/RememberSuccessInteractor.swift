//
//  RememberSuccessInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 02.09.2020.
//

import Foundation
import UIKit

protocol RememberSuccessInteractorProtocol: class {
    func configureView(with number: String)
}

class RememberSuccessInteractor: RememberSuccessInteractorProtocol {
    weak var viewController: RememberSuccessController!
    weak var presenter: RememberSuccessPresenterProtocol!
    
    init(viewController: RememberSuccessController, presenter: RememberSuccessPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView(with number: String) {
        viewController.descriptionText.text = "Мы отправили СМС с паролем к Вашему аккаунту на телефон \(number)"
    }

}
