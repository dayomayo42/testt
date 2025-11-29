//
//  ShedulePlaceHolderView.swift
//  iProfi_new
//
//  Created by violy on 21.04.2023.
//

import Foundation
import UIKit

class ShedulePlaceHolderView: UIView {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var goToSheduleSettingButton: UIButton!
    
    var onGoToSheduleTappedAction: (() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        fromNib()
    }
    
    func configure(type: ShedulePlaceholderType, goToSheduleHidden: Bool) {
        switch type {
        case .sheduleNotFilled:
            titleLabel.text = "Тут пусто"
            descriptionLabel.text = "Расписание на данный день недели не заполнено."
        case .weekendPlaceholder:
            titleLabel.text = "Сегодня выходной"
            descriptionLabel.text = "По вашему расписанию сегодня выходной, откиньтесь на спинку кресла и отдохните."
        }
        goToSheduleSettingButton.isHidden = goToSheduleHidden
    }
    
    @IBAction func onGoToSheduleTapped() {
        onGoToSheduleTappedAction?()
    }
}

/// Типы плейсхолдера
enum ShedulePlaceholderType {
    case weekendPlaceholder /// - если текущий день выходной в расписании
    case sheduleNotFilled /// - если расписание не заполненено
}
