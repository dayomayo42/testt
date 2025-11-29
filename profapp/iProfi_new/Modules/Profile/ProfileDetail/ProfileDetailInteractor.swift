//
//  ProfileDetailInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 23.10.2020.
//

import Foundation
import Moya
import RxSwift
import SVProgressHUD
import UIKit
import PhoneNumberKit

protocol ProfileDetailInteractorProtocol: class {
    func configureView()
    func editMode(edit: Bool)
    func addSpec(pos: Int)
    func openSpec(pos: Int)
    func deleteSpec(pos: Int)
    func toCountryList()
    func configureView(with model: CountriesModel?)
    func deleteAccount()
    func checkEdit()
    func openSphereList()
}

class ProfileDetailInteractor: ProfileDetailInteractorProtocol {
    weak var viewController: ProfileDetailController!
    var presenter: ProfileDetailPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    let phoneNumberKit = PhoneNumberKit()
    
    var specs: [Spec] = [] {
        didSet {
            configureSpec()
        }
    }

    init(viewController: ProfileDetailController, presenter: ProfileDetailPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }

    func configureView() {
        viewController.deleteAccountButton.isUserInteractionEnabled = true
        
        let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: viewController.view.frame.size.width, height: 30))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(doneButtonAction))
        doneBtn.tintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        viewController.numberField.setup()
       // PhoneNumberKit.CountryCodePicker.commonCountryCodes = ["US", "CA", "RU", "AU", "GB", "DE"]
//        viewController.numberField.withExamplePlaceholder = true
//        viewController.numberField.withFlag = true
//        viewController.numberField.withDefaultPickerUI = true
//        viewController.numberField.withPrefix = true
//        viewController.listener.delegate = viewController
//        viewController.numberField.delegate = viewController.listener
//        viewController.listener.affinityCalculationStrategy = .prefix
//        viewController.listener.affiteFormats = [
//            "+7[000][000][00][00]",
//        ]
//
//        viewController.listener.primaryMaskFormat = "+7[000][000][00][00]"
        
        viewController.numberField.inputAccessoryView = toolbar
        viewController.mailField.inputAccessoryView = toolbar
        viewController.vkField.inputAccessoryView = toolbar
        viewController.instagramField.inputAccessoryView = toolbar
        viewController.facebookField.inputAccessoryView = toolbar
        viewController.lastNameField.inputAccessoryView = toolbar
        viewController.nameField.inputAccessoryView = toolbar
        viewController.patronymicField.inputAccessoryView = toolbar
        viewController.cityField.inputAccessoryView = toolbar
        viewController.addressField.inputAccessoryView = toolbar
        
        let model = viewController.userModel
        viewController.cityField.text = model?.city
        viewController.addressField.text = model?.address
        viewController.numberField.text = model?.phone
        viewController.mailField.text = model?.email
        viewController.vkField.text = model?.vk?.contains("vk.com") ?? false ? model?.vk : "vk.com/"
        viewController.instagramField.text = model?.instagram?.contains("instagram.com") ?? false ? model?.instagram : "instagram.com/"
        viewController.facebookField.text = model?.fb?.contains("facebook.com") ?? false ? model?.fb : "facebook.com/"
        viewController.lastNameField.text = model?.lastname
        viewController.nameField.text = model?.name
        viewController.patronymicField.text = model?.midname
        viewController.sphereField.text = model?.sphere?.name
        if specs.count == 0 {
            specs = viewController.userModel?.specs ?? []
        }
    }

    func configureSpec() {
        viewController.count = specs.count
        
        switch specs.count {
        case 0:
            viewController.mainSpec.isHidden = false
            viewController.dopSpecOne.isHidden = true
            viewController.dopSpecTwo.isHidden = true
            viewController.dopSpecThree.isHidden = true
            viewController.addSpecPlate.isHidden = true
            viewController.mainSpec.isUserInteractionEnabled = true
        case 1:
            viewController.mainSpec.isHidden = false
            viewController.dopSpecOne.isHidden = true
            viewController.dopSpecTwo.isHidden = true
            viewController.dopSpecThree.isHidden = true
            viewController.mainSpecLabel.text = specs[0].name?.capitalized
            viewController.mainSpec.isUserInteractionEnabled = true
            viewController.addSpecPlate.isHidden = false
        case 2:
            viewController.mainSpec.isHidden = false
            viewController.dopSpecOne.isHidden = false
            viewController.dopSpecTwo.isHidden = true
            viewController.dopSpecThree.isHidden = true
            viewController.mainSpecLabel.text = specs[0].name?.capitalized
            viewController.dopSpecOneLabel.text = specs[1].name?.capitalized
            viewController.mainSpec.isUserInteractionEnabled = true
            viewController.addSpecPlate.isHidden = false
        case 3:
            viewController.mainSpec.isHidden = false
            viewController.dopSpecOne.isHidden = false
            viewController.dopSpecTwo.isHidden = false
            viewController.dopSpecThree.isHidden = true
            viewController.mainSpecLabel.text = specs[0].name?.capitalized
            viewController.dopSpecOneLabel.text = specs[1].name?.capitalized
            viewController.dopSpecTwoLabel.text = specs[2].name?.capitalized
            viewController.mainSpec.isUserInteractionEnabled = true
            viewController.addSpecPlate.isHidden = false
        case 4:
            viewController.mainSpec.isHidden = false
            viewController.dopSpecOne.isHidden = false
            viewController.dopSpecTwo.isHidden = false
            viewController.dopSpecThree.isHidden = false
            viewController.mainSpecLabel.text = specs[0].name
            viewController.dopSpecOneLabel.text = specs[1].name?.capitalized
            viewController.dopSpecTwoLabel.text = specs[2].name?.capitalized
            viewController.dopSpecThreeLabel.text = specs[3].name?.capitalized
            viewController.mainSpec.isUserInteractionEnabled = true
            viewController.addSpecPlate.isHidden = true
        default: break
        }
        
        viewController.dropMainSpecImageView.isHidden = !(viewController.mainSpecLabel.text?.withoutSpaces().count ?? 0 > 0)
        viewController.mainSpecArrowImageView.isHidden = viewController.mainSpecLabel.text?.withoutSpaces().count ?? 0 > 0
    }
    
    @objc func doneButtonAction() {
        viewController.view.endEditing(true)
    }

    func postProfile() {
        SVProgressHUD.show()
        let model = viewController.userModel
        var convertedPhone = ""
        
//        if viewController.numberField.text?.count ?? 0 > 0 {
//            do {
//                let newNum = "+" + (viewController.numberField.text ?? "")
//                let phoneNumber = try phoneNumberKit.parse(newNum)
//                convertedPhone = phoneNumberKit.format(phoneNumber, toType: .e164)
//            } catch let error {
//                debugPrint(error)
//            }
//        }

        viewController.userModel = UserModel(id: model?.id, sphereID: model?.sphereID, name: viewController.nameField.text ?? "", midname: viewController.patronymicField.text, lastname: viewController.lastNameField.text, image: model?.image, email: viewController.mailField.text ?? "", phone: convertedPhone , vk: viewController.vkField.text ?? "", fb: viewController.facebookField.text ?? "", instagram: viewController.instagramField.text ?? "", city: viewController.cityField.text ?? "", address: viewController.addressField.text ?? "", onlineRecord: model?.onlineRecord, siteLink: model?.siteLink, sphere: model?.sphere, specs: model?.specs)
        
        service.postEditedModel(model: viewController.userModel!).subscribe { response in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if !(response.success ?? false) {
                    SVProgressHUD.showError(withStatus: response.message)
                }
            }
        } onError: { error in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }

    func openSpec(pos: Int) {
        let vc = viewController.getControllerProfile(controller: .spec) as! SpecController
        vc.pos = pos
        vc.inter = self
        if let sphereID = viewController.userModel?.sphereID {
            vc.sphereID = "/\(sphereID)"
        }
        viewController.navigationController?.pushViewController(vc, animated: true)
    }

    func editMode(edit: Bool) {
        if viewController.isEditMode {
            viewController.userModel?.specs = specs
            postProfile()
        }
        viewController.isEditMode = edit
        if edit {
            viewController.plates.forEach { view in
                if view != viewController.numberPlate {
                    view.isUserInteractionEnabled = true
                    view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                }
            }
            viewController.specInfoLabel.isHidden = false
            if specs.count > 0 && specs.count < 4 {
                viewController.addSpecPlate.isHidden = false
            } else if specs.count == 0 || specs.count == 4 {
                viewController.addSpecPlate.isHidden = true
            }
            viewController.editButton.setTitle("Сохранить", for: .normal)
            viewController.editButton.setImage(UIImage(), for: .normal)
        } else {
            viewController.plates.forEach { view in
                view.isUserInteractionEnabled = false
                view.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9882352941, blue: 1, alpha: 1)
            }
            viewController.addSpecPlate.isHidden = true
            viewController.specInfoLabel.isHidden = true
            viewController.editButton.setTitle("", for: .normal)
            viewController.editButton.setImage(#imageLiteral(resourceName: "pen"), for: .normal)
            viewController.view.endEditing(true)
        }
    }
    
    func checkEdit() {
        guard let vc = viewController else { return }
        guard vc.isEditMode == true else { return }
        if vc.nameField.text?.withoutSpaces().count ?? 0 < 1 {
            vc.editButton.isUserInteractionEnabled = false
            vc.editButton.setTitleColor(UIColor(named: "buttondismiss"), for: .normal)
        } else {
            vc.editButton.isUserInteractionEnabled = true
            vc.editButton.setTitleColor(UIColor(named: "appBlue"), for: .normal)
        }
    }

    func addSpec(pos: Int) {
        if pos < 4 {
            viewController.count += 1
            openSpec(pos: pos)
        }
    }

    func deleteSpec(pos: Int) {
        if pos == 0 {
            viewController.mainSpecLabel.text = ""
            specs = []
        } else {
            specs.remove(at: pos)
        }
    }
    
    func configureView(with model: CountriesModel?) {
        viewController.numberField.text = ""
//        viewController.listener.primaryMaskFormat = "+\(model?.phoneMask ?? "")[000][000][000][000]"
    }
    
    func logout() {
        let vc = self.viewController.getController(controller: .launch)
        Authorization.token = nil
        Authorization.name = nil
        Authorization.id = nil
        
        Settings.calendar = false
        Settings.currency = nil
        Settings.currencyCym = nil
        Settings.onlinerecord = nil
        UIApplication.shared.keyWindow?.rootViewController = NavigationController(rootViewController: vc)
    }
    
    func deleteAccount() {
        let alert = UIAlertController(
            title: "Удалить аккаунт?",
            message: "После удаления аккаунт нельзя будет восстановить, удалить?",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Удалить", style: .default, handler: { (action: UIAlertAction!) in
            SVProgressHUD.show()
            self.service.deleteAccount().subscribe { response in
                SVProgressHUD.dismiss()
                self.logout()
            } 
        }))
        
        alert.addAction(UIAlertAction(title: "Нет", style: .default, handler: { (action: UIAlertAction!) in
            print("Отменить")
        }))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    func openSphereList() {
        SVProgressHUD.show()
        
        let onSelectSphereClosure: ((SphereModel)->()) = { [weak self] sphere in
                self?.viewController.sphereField.text = sphere.name
                self?.viewController.userModel?.sphereID = sphere.id
                self?.specs = []
                self?.viewController.mainSpecLabel.text = ""
        }
        
        service.getSpheres().subscribe { (response) in
            SVProgressHUD.dismiss()
            
            if self.viewController != nil {
                if response.success ?? false {
                    let spheres = response.data ?? []
                    self.presenter.openSpheres(sphereList: spheres, onSelect: onSelectSphereClosure)
                } else {
                    SVProgressHUD.showError(withStatus: response.message)
                }
            }
        } onError: { (error) in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        } onCompleted: {
        }.disposed(by: disposeBag)
        
    }

    func toCountryList() {
        let vc = viewController.getController(controller: .country) as! ChooseCountryController
        vc.authPresenter = presenter
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
