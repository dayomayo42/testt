//
//  UpdateScreenInteractor.swift
//  iProfi_new
//
//  Created by violy on 19.01.2023.
//

import Foundation

protocol UpdateScreenInteractorProtocol {
    func configureView()
}

class UpdateScreenInteractor: UpdateScreenInteractorProtocol {
    var viewController: UpdateScreenViewController!
    var presenter: UpdateScreenPresenterProtocol!
    
    init(viewController: UpdateScreenViewController, presenter: UpdateScreenPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
        guard let vc = viewController else { return }
        
        switch vc.updateScreenState {
        case .common:
            vc.descriptionLabel.text = "Новая версия работает быстрее. В ней исправлены ошибки и добавлены полезные функции. Обычно обновление занимает не больше минуты"
            vc.skipUpdateButton.isHidden = false
        case .forced:
            vc.descriptionLabel.text = "Данная версия больше не поддерживается, необходимо обновить приложение"
            vc.skipUpdateButton.isHidden = true
        default:
            break
        }
    }
}
