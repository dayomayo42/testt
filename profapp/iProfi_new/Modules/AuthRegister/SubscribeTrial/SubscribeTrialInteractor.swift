//
//  SubscribeTrialInteractor.swift
//  iProfi_new
//
//  Created by violy on 20.01.2023.
//

import Foundation
import UIKit

protocol SubscribeTrialInteractorProtocol {
    func configureView()
}

class SubscribeTrialInteractor: SubscribeTrialInteractorProtocol {
    var viewController: SubscribeTrialViewController!
    var presenter: SubscribeTrialPresenterProtocol!
    
    init(viewController: SubscribeTrialViewController, presenter: SubscribeTrialPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
        guard let vc = viewController else { return }
        
        switch vc.subState {
        case .common:
            vc.imageView.image = UIImage(named: "subscribe_plug1")
            vc.titleLabel.text = "Полный функционал приложения – бесплатно!"
            vc.descriptionLabel.text = "Мы подготовили для вас пробную подписку. На первые 14 дней вам предоставлен полный функционал приложения, по его окончанию, вы сможете оформить подписку, с понравившимся функционалом"
            vc.blueMainButton.setTitle("Хорошо", for: .normal)
            vc.whiteSecondaryButton.isHidden = true
        case .expired:
            vc.imageView.image = UIImage(named: "subscribe_plug2")
            vc.titleLabel.text = "Пробный период закончился"
            vc.descriptionLabel.text = "Ваша пробная подписка закончилась. Если вы хотите продолжить пользоваться всем функционалом приложения, оформите себе подписку"
            vc.blueMainButton.setTitle("Выбрать подписку", for: .normal)
            vc.whiteSecondaryButton.setTitle("Не сейчас", for: .normal)
            vc.whiteSecondaryButton.isHidden = false
        default:
            break
        }
    }
}
