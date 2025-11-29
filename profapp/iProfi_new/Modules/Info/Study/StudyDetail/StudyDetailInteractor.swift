//
//  StudyDetailInteractor.swift
//  iProfi_new
//
//  Created by violy on 12.08.2022.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD
import StoreKit


protocol StudyDetailInteractorProtocol {
    func configureView()
    func postJoinCourse(model: JoinCourseModel)
}

class StudyDetailInteractor: StudyDetailInteractorProtocol {
    var viewController: StudyDetailController!
    var presenter: StudyDetailPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    
    init(viewController: StudyDetailController, presenter: StudyDetailPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
        guard let vc = viewController else { return }
        vc.numberField.setup()
        vc.nameField.text = Authorization.name
        vc.surNameField.text = Authorization.lastame
        vc.numberField.text = Authorization.phone
        vc.textFieldDidChange(UITextField())
        
        vc.descriptionTextView.textContainerInset.left = -4
        vc.descriptionTextView.textContainerInset.right = -4
        let imageUrl = vc.model?.image
        let title = vc.model?.name ?? ""
        let desc = vc.model?.datumDescription
        let price = vc.model?.price
        setupView(imageUrl: imageUrl, title: title, desc: desc, price: price)
        
        
        vc.gradientView.isHidden = title.count == 0
        
        if vc.model?.subscribed ?? false {
            vc.nameFieldPlate.isHidden = true
            vc.numberFieldPlate.isHidden = true
            vc.surnameFieldPlate.isHidden = true
            vc.enrollButtonPlate.isHidden = true
        }
        
        if let type = vc.model?.type {
            switch type {
            case "courses/consultation":
                vc.headerTitileLabel.text = "Консультации"
            case "courses/qualification":
                vc.headerTitileLabel.text = "Повыш. квалификации"
            case "courses/webinar":
                vc.headerTitileLabel.text = "Вебинары"
            default:
                vc.headerTitileLabel.text = ""
            }
        }
        
        let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: vc.view.frame.size.width, height: 30))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(doneButtonAction))
        doneBtn.tintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        
        vc.nameField.inputAccessoryView = toolbar
        vc.surNameField.inputAccessoryView = toolbar
        vc.numberField.inputAccessoryView = toolbar
        vc.numberField.keyboardType = .asciiCapableNumberPad
    }
    
   
    
    @objc func doneButtonAction() {
        guard let vc = viewController else { return }
        vc.view.endEditing(true)
        vc.scrollView.contentSize.height = vc.stackView.frame.height + vc.sliderPlate.frame.height + 16
    }
    
    func setupView(imageUrl: String?, title: String?, desc: String?, price: Int?) {
        guard let title = title else { return }
        guard let desc = desc else { return }
        guard let vc = viewController else { return }
        
        if let url = URL(string: imageUrl ?? "") {
            vc.detailStudyImageView.contentMode = .scaleAspectFill
            vc.detailStudyImageView.af_setImage(withURL: url)
        }
        
        if let price = price {
            vc.priceLabel.text = "\(price) руб."
            vc.pricePlateView.isHidden = false
        } else {
            vc.pricePlateView.isHidden = true
        }
        
        vc.detailStudyTitleLabel.text = title
        vc.titleLabel.text = title
        vc.descriptionTextView.text = desc
    }
    
    func postJoinCourse(model: JoinCourseModel) {
        
        let alert = UIAlertController(
            title: "Подтверждение записи",
            message: "После произведение записи, с вами свяжутся для уточнения деталей",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Да", style: .default, handler: { (action: UIAlertAction!) in
            print("Да")
            
            SVProgressHUD.show()
            self.service.postJoinCourse(model: model).subscribe { (response) in
                SVProgressHUD.dismiss()
                if self.viewController != nil {
                    if response.success ?? false {
                        self.presenter.backAction()
                        if let id = model.id {
                            self.viewController.delegate?.updateSlideSubscribeFor(id: id)
                        }
                        SVProgressHUD.showDismissableSuccess(withStatus: "Запись на курс произведена успешно")
                    } else {
                        SVProgressHUD.showDismissableError(withStatus: response.message ?? "response error")
                    }
                }
            } onError: { (error) in
                SVProgressHUD.showDismissableError(withStatus: error.localizedDescription)
            }.disposed(by: self.disposeBag)
        }
        ))
        
        alert.addAction(UIAlertAction(title: "Нет", style: .default, handler: { (action: UIAlertAction!) in
        }))
        
        viewController.present(alert, animated: true, completion: nil)
    }
}
